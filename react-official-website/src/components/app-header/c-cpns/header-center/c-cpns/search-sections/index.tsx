import React, { memo } from 'react'
import type { FC, ReactNode } from 'react'
import { SectionsWrapper } from './style'

interface IProps {
  children?: ReactNode
  searchInfos: any
}

const SearchSections: FC<IProps> = (props) => {
  const { searchInfos } = props
  return (
    <SectionsWrapper>
      <div className="content">
        {searchInfos.map((item: any, index: number) => {
          return (
            <div className="item" key={index}>
              <div className="info">
                <div className="title">{item.title}</div>
                <div className="desc">{item.desc}</div>
              </div>
            </div>
          )
        })}
      </div>
    </SectionsWrapper>
  )
}

export default memo(SearchSections)
