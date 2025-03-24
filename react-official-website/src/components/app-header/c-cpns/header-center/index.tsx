import React, { memo, useState, useRef } from 'react'
import type { FC, ReactNode } from 'react'
import { CenterWrapper } from '@/components/app-header/c-cpns/header-center/style'
import IconSearchBar from '@/assets/svg/icon-search-bar'
import SearchTabs from '@/components/app-header/c-cpns/header-center/c-cpns/search-tabs'
import searchTitles from '@/assets/data/search_titles.json'
import SearchSections from '@/components/app-header/c-cpns/header-center/c-cpns/search-sections'
import { CSSTransition } from 'react-transition-group'

interface IProps {
  children?: ReactNode
  isSearch: boolean
  searchBarClick: () => void
}

const HeaderCenter: FC<IProps> = (props) => {
  const { isSearch, searchBarClick } = props
  const [tabIndex, setTabIndex] = useState(0)
  const titles = searchTitles.map((item) => item.title)

  // 添加 refs
  const nodeRef1 = useRef(null)
  const nodeRef2 = useRef(null)

  function searchBarClickHandle() {
    searchBarClick && searchBarClick()
  }

  const handleItemClick = (url: string) => {
    // 使用直接跳转方式
    window.location.href = url
    searchBarClick() // 点击后关闭搜索框
  }

  return (
    <CenterWrapper>
      <CSSTransition
        in={!isSearch}
        classNames="bar"
        timeout={250}
        unmountOnExit={true}
        nodeRef={nodeRef1}
      >
        <div ref={nodeRef1} onClick={searchBarClickHandle}></div>
      </CSSTransition>
      <CSSTransition
        in={isSearch}
        classNames="detail"
        timeout={250}
        unmountOnExit={true}
        nodeRef={nodeRef2}
      >
        <div ref={nodeRef2} className="search-detail">
          <SearchTabs titles={titles} tabClick={setTabIndex} />
          <div className="infos">
            <SearchSections
              searchInfos={searchTitles[tabIndex].searchInfos}
              onItemClick={handleItemClick}
            />
          </div>
        </div>
      </CSSTransition>
    </CenterWrapper>
  )
}

export default memo(HeaderCenter)
