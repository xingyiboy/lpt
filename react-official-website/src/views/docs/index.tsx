/*
 * @Date: 2025-03-24 21:02:16
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-03-24 22:19:56
 * @FilePath: \react-official-website\src\views\docs\index.tsx
 */
import React, { useState, useEffect, useCallback, memo } from 'react'
import { useNavigate, useLocation } from 'react-router-dom'
import { IconType } from 'react-icons'
import { FiArrowUp, FiSun, FiMoon, FiBook } from 'react-icons/fi'
import { IoShirtOutline } from 'react-icons/io5'
import styled from 'styled-components'
import {
  DocWrapper,
  Header,
  Logo,
  Title,
  SearchBar,
  NavLinks,
  MainContent,
  Sidebar,
  Content,
  RightSidebar,
  FloatingButtons,
  SidebarSection,
  SectionTitle,
  SidebarItem,
  ThemeDropdown,
  ThemeOption,
  IconButton
} from './style'
import docsData from '@/assets/data/docs.json'
import { useTheme } from '@/hooks/useTheme'

interface ThemeOptionType {
  value: string
  label: string
  icon: IconType
}

interface DocSection {
  id: string
  title: string
  scrollPosition: number
  content: string
}

interface DocContent {
  title: string
  path: string
  sections?: DocSection[]
}

interface SearchResult {
  title: string
  path: string
  content: string
  matchText: string
  sectionTitle: string
  scrollPosition: number
}

const DocsPage: React.FC = () => {
  const location = useLocation()
  const navigate = useNavigate()
  const [currentContent, setCurrentContent] = useState<DocContent | null>(null)
  const [theme, setTheme] = useState(() => {
    // 从本地存储读取主题，如果没有则默认为 'reading'
    return localStorage.getItem('docs-theme') || 'reading'
  })
  const [showSidebar, setShowSidebar] = useState(true)
  const [searchKeyword, setSearchKeyword] = useState('')
  const [showThemeDropdown, setShowThemeDropdown] = useState(false)
  const [showSearchResults, setShowSearchResults] = useState(false)
  const [searchResults, setSearchResults] = useState<SearchResult[]>([])
  const { theme: themeFromUseTheme, setTheme: setThemeFromUseTheme } =
    useTheme()

  const themeOptions: ThemeOptionType[] = [
    {
      value: 'light',
      label: '白天模式',
      icon: FiSun
    },
    {
      value: 'dark',
      label: '夜间模式',
      icon: FiMoon
    },
    {
      value: 'reading',
      label: '阅读模式',
      icon: FiBook
    }
  ]

  // 将文档查找逻辑抽离出来
  const findDocByPath = (path: string): DocContent | undefined => {
    const allDocs = docsData.sidebar.flatMap((section) => section.children)
    return allDocs.find((doc) => doc.path === path) as DocContent
  }

  // 初始化时设置当前内容
  useEffect(() => {
    // 设置主题
    const savedTheme = localStorage.getItem('docs-theme') || 'reading'
    setTheme(savedTheme)
    document.body.setAttribute('data-theme', savedTheme)

    // 设置文档内容
    const currentPath = location.pathname.replace('/docs', '')
    const currentDoc = findDocByPath(currentPath)

    if (currentDoc) {
      setCurrentContent(currentDoc)
    } else {
      // 如果没有找到对应文档，重定向到默认文档
      const defaultDoc = docsData.sidebar[0].children[0] as DocContent
      setCurrentContent(defaultDoc)
      if (location.pathname !== `/docs${defaultDoc.path}`) {
        navigate(`/docs${defaultDoc.path}`, { replace: true })
      }
    }
  }, []) // 只在组件挂载时执行一次

  // 处理路由变化
  useEffect(() => {
    const currentPath = location.pathname.replace('/docs', '')
    const doc = findDocByPath(currentPath)
    if (doc && (!currentContent || currentContent.path !== doc.path)) {
      setCurrentContent(doc)
    }
  }, [location.pathname])

  const handleMenuClick = useCallback(
    (item: DocContent) => {
      if (location.pathname !== `/docs${item.path}`) {
        setCurrentContent(item)
        navigate(`/docs${item.path}`, { replace: true })
      }
    },
    [navigate, location.pathname]
  )

  const handleSearchResultClick = (result: SearchResult) => {
    navigate(`/docs${result.path}`)

    setTimeout(() => {
      window.scrollTo({
        top: result.scrollPosition,
        behavior: 'smooth'
      })
    }, 100)

    setShowSearchResults(false)
  }

  const handleSearch = (keyword: string) => {
    const results: SearchResult[] = []
    const searchKeyword = keyword.toLowerCase()

    if (!searchKeyword) {
      setSearchResults([])
      setShowSearchResults(false)
      return
    }

    // 辅助函数：移除 HTML 标签
    const stripHtml = (html: string) => {
      const tmp = document.createElement('div')
      tmp.innerHTML = html
      return tmp.textContent || tmp.innerText || ''
    }

    docsData.sidebar.forEach((section) => {
      section.children.forEach((item) => {
        item.sections?.forEach((section) => {
          // 移除 HTML 标签后的纯文本内容
          const plainContent = stripHtml(section.content)

          // 只搜索纯文本内容
          if (plainContent.toLowerCase().includes(searchKeyword)) {
            // 找到关键词在文本中的位置
            const keywordIndex = plainContent
              .toLowerCase()
              .indexOf(searchKeyword)
            // 获取关键词前后的一些文本，作为上下文
            const start = Math.max(0, keywordIndex - 50)
            const end = Math.min(plainContent.length, keywordIndex + 100)
            const context = plainContent.substring(start, end)

            results.push({
              title: item.title,
              path: item.path,
              content: section.content,
              matchText: context,
              sectionTitle: section.title,
              scrollPosition: section.scrollPosition
            })
          }
        })
      })
    })

    // 去重，基于路径和章节标题
    const uniqueResults = results.filter(
      (result, index, self) =>
        index ===
        self.findIndex(
          (r) =>
            r.path === result.path && r.sectionTitle === result.sectionTitle
        )
    )

    setSearchResults(uniqueResults)
    setShowSearchResults(true)
  }

  const scrollToTop = () => {
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }

  const handleSectionClick = (scrollPosition: number) => {
    window.scrollTo({ top: scrollPosition, behavior: 'smooth' })
  }

  const renderContent = () => {
    if (!currentContent?.sections) return null
    return (
      <div>
        {currentContent.sections.map((section) => (
          <div key={section.id} id={section.id}>
            <div dangerouslySetInnerHTML={{ __html: section.content }} />
          </div>
        ))}
      </div>
    )
  }

  const handleThemeChange = (newTheme: string) => {
    setTheme(newTheme)
    setShowThemeDropdown(false)
    // 保存主题到本地存储
    localStorage.setItem('docs-theme', newTheme)
    // 设置全局样式
    document.body.setAttribute('data-theme', newTheme)
  }

  // 创建一个通用的图标渲染函数
  const renderIcon = (Icon: IconType, size = 20) => {
    const Component = Icon as React.ComponentType<{ size: number }>
    return <Component size={size} />
  }

  return (
    <DocWrapper theme={theme}>
      <Header>
        <div
          style={{
            display: 'flex',
            alignItems: 'center',
            gap: '20px',
            cursor: 'pointer'
          }}
          onClick={() => (window.location.href = '/home')}
        >
          <Logo src="/favicon.ico" alt="Logo" />
          <Title>LPT 开发指南（文档更新时间：2025-3-30）</Title>
        </div>
        <SearchBar>
          <input
            type="text"
            placeholder="搜索文档..."
            value={searchKeyword}
            onChange={(e) => {
              setSearchKeyword(e.target.value) // 先更新搜索关键词
              handleSearch(e.target.value) // 然后执行搜索
            }}
          />
          {showSearchResults && searchResults.length > 0 && (
            <SearchResults>
              {searchResults.map((result, index) => (
                <SearchResultItem
                  key={index}
                  onClick={() => handleSearchResultClick(result)}
                >
                  <ResultTitle>{result.title}</ResultTitle>
                  {result.sectionTitle && (
                    <ResultSection>» {result.sectionTitle}</ResultSection>
                  )}
                  <ResultMatch>{result.matchText}</ResultMatch>
                </SearchResultItem>
              ))}
            </SearchResults>
          )}
        </SearchBar>
        <NavLinks>
          {/* <a href="/guide">开发指南</a>
          <a href="/project">项目实战</a>
          <a href="/video">视频教程</a> */}
          <a
            href="https://113.45.31.128"
            target="_blank"
            rel="noopener noreferrer"
          >
            在线体验
          </a>
          <a
            href="http://113.45.31.128:99/user/login"
            target="_blank"
            rel="noopener noreferrer"
          >
            接口平台
          </a>
          <a href="#">作者博客</a>
          <a href="#" target="_blank" rel="noopener noreferrer">
            GitHub
          </a>
        </NavLinks>
      </Header>

      <MainContent>
        <Sidebar show={showSidebar}>
          {docsData.sidebar.map((section, index) => (
            <SidebarSection key={index}>
              <SectionTitle>{section.title}</SectionTitle>
              {section.children.map((item, itemIndex) => (
                <SidebarItem
                  key={itemIndex}
                  active={location.pathname === `/docs${item.path}`}
                  onClick={() => handleMenuClick(item as DocContent)}
                >
                  {item.title}
                </SidebarItem>
              ))}
            </SidebarSection>
          ))}
        </Sidebar>

        <Content>{renderContent()}</Content>

        <RightSidebar>
          <h3 className="toc-title">目录</h3>
          <ul className="toc-list">
            {currentContent?.sections?.map((section) => (
              <li
                key={section.id}
                className="toc-item"
                onClick={() => handleSectionClick(section.scrollPosition)}
              >
                {section.title}
              </li>
            ))}
          </ul>
        </RightSidebar>
      </MainContent>

      <FloatingButtons>
        <IconButton onClick={scrollToTop}>{renderIcon(FiArrowUp)}</IconButton>
        <IconButton onClick={() => setShowThemeDropdown(!showThemeDropdown)}>
          {renderIcon(IoShirtOutline)}
          <ThemeDropdown show={showThemeDropdown}>
            {themeOptions.map((option) => (
              <ThemeOption
                key={option.value}
                active={theme === option.value}
                onClick={() => handleThemeChange(option.value)}
              >
                {renderIcon(option.icon, 16)}
              </ThemeOption>
            ))}
          </ThemeDropdown>
        </IconButton>
      </FloatingButtons>
    </DocWrapper>
  )
}

// 搜索结果样式组件
const SearchResults = styled.div`
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: white;
  border: 1px solid #ddd;
  border-radius: 4px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
  max-height: 400px;
  overflow-y: auto;
  z-index: 1000;
`

const SearchResultItem = styled.div`
  padding: 12px;
  cursor: pointer;
  border-bottom: 1px solid #eee;

  &:last-child {
    border-bottom: none;
  }

  &:hover {
    background: #f5f5f5;
  }
`

const ResultTitle = styled.div`
  font-weight: bold;
  color: #333;
  margin-bottom: 4px;
`

const ResultSection = styled.div`
  color: #666;
  font-size: 0.9em;
  margin-bottom: 4px;
`

const ResultMatch = styled.div`
  color: #888;
  font-size: 0.9em;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
`

export default memo(DocsPage)
