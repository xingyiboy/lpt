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

interface DocContent {
  title: string
  path: string
  content?: string
  sections?: Array<{
    id: string
    title: string
  }>
}

interface DocSection {
  title: string
  children: DocContent[]
}

interface SearchResult {
  title: string
  path: string
  content: string
  matchText: string
  sectionTitle?: string
}

const DocsPage: React.FC = () => {
  const location = useLocation()
  const navigate = useNavigate()
  const [currentContent, setCurrentContent] = useState<DocContent | null>(null)
  const [theme, setTheme] = useState('reading')
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
  const findDocByPath = (path: string) => {
    const allDocs = docsData.sidebar.flatMap((section) => section.children)
    return allDocs.find((doc) => doc.path === path)
  }

  // 初始化时设置当前内容
  useEffect(() => {
    // 设置主题
    if (!document.body.getAttribute('data-theme')) {
      setTheme('reading')
      document.body.setAttribute('data-theme', 'reading')
    }

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

  const handleSearchResultClick = useCallback(
    (result: SearchResult) => {
      setCurrentContent({
        title: result.title,
        path: result.path,
        content: result.content,
        sections: findDocByPath(result.path)?.sections
      })
      navigate(`/docs${result.path}`, { replace: true })
      setShowSearchResults(false)
      setSearchKeyword('')
    },
    [navigate]
  )

  const handleSearch = (value: string) => {
    setSearchKeyword(value)

    if (!value.trim()) {
      setSearchResults([])
      setShowSearchResults(false)
      return
    }

    const results: SearchResult[] = []
    const keyword = value.toLowerCase()

    // 搜索所有文档内容
    docsData.sidebar.forEach((section) => {
      section.children.forEach((item) => {
        if (item.content) {
          // 搜索标题
          if (item.title.toLowerCase().includes(keyword)) {
            results.push({
              title: item.title,
              path: item.path,
              content: item.content,
              matchText: item.title
            })
          }

          // 搜索内容
          const contentLines = item.content.split('\n')
          contentLines.forEach((line) => {
            if (line.toLowerCase().includes(keyword)) {
              results.push({
                title: item.title,
                path: item.path,
                content: item.content,
                matchText: line.trim(),
                sectionTitle: line.startsWith('#')
                  ? line.replace(/#/g, '').trim()
                  : undefined
              })
            }
          })

          // 搜索章节标题
          item.sections?.forEach((section) => {
            if (section.title.toLowerCase().includes(keyword)) {
              results.push({
                title: item.title,
                path: item.path,
                content: item.content,
                matchText: section.title,
                sectionTitle: section.title
              })
            }
          })
        }
      })
    })

    setSearchResults(results)
    setShowSearchResults(true)
  }

  const scrollToTop = () => {
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }

  // 处理右侧目录点击
  const handleSectionClick = (sectionId: string) => {
    const element = document.getElementById(sectionId)
    if (element) {
      element.scrollIntoView({ behavior: 'smooth' })
    }
  }

  const renderContent = () => {
    if (!currentContent?.content) return null

    const paragraphs = currentContent.content.split('\n\n').map((p, index) => {
      // 处理图片
      if (p.startsWith('![')) {
        const match = p.match(/!\[(.*?)\]\((.*?)\)/)
        if (match) {
          const [_, alt, src] = match
          return (
            <div key={index} className="image-container">
              <img src={src} alt={alt} className="content-image" />
            </div>
          )
        }
      }

      // 处理视频
      if (p.startsWith('<video')) {
        const match = p.match(/src='(.*?)'/)
        if (match) {
          const [_, src] = match
          return (
            <div key={index} className="video-container">
              <video src={src} controls className="content-video" />
            </div>
          )
        }
      }

      // 处理标题和其他内容...
      if (p.startsWith('# ')) {
        return (
          <h1 key={index} className="main-title">
            {p.substring(2)}
          </h1>
        )
      }
      if (p.startsWith('## ')) {
        const title = p.substring(3)
        return (
          <h2 key={index} id={`section-${index}`} className="section-title">
            {title}
          </h2>
        )
      }
      return (
        <p key={index} className="content-paragraph">
          {p}
        </p>
      )
    })

    return paragraphs
  }

  const handleThemeChange = (newTheme: string) => {
    setTheme(newTheme)
    setShowThemeDropdown(false)
    // 根据主题设置全局样式
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
          <Title>LPT 开发指南（文档更新时间：2025-3-24）</Title>
        </div>
        <SearchBar>
          <input
            type="text"
            placeholder="搜索文档..."
            value={searchKeyword}
            onChange={(e) => handleSearch(e.target.value)}
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
                  active={location.pathname === item.path}
                  onClick={() => handleMenuClick(item)}
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
            {currentContent?.sections?.map((section, index) => (
              <li
                key={section.id}
                className="toc-item"
                onClick={() => handleSectionClick(`section-${index}`)}
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
