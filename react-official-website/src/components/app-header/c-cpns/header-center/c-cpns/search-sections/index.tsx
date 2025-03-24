/* eslint-disable react/prop-types */
import React, { memo } from 'react'
import type { FC } from 'react'
import { SectionsWrapper } from './style'

interface IProps {
  searchInfos: {
    title: string
    desc: string
    url: string
  }[]
  onItemClick: (url: string) => void
}

const SearchSections: FC<IProps> = memo((props) => {
  const { searchInfos, onItemClick } = props

  return (
    <SectionsWrapper>
      <div className="content">
        {searchInfos.map((item, index) => {
          return (
            <div
              key={index}
              className="item"
              onClick={() => onItemClick(item.url)}
            >
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
})

SearchSections.displayName = 'SearchSections'

export default SearchSections
