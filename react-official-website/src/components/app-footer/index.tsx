/*
 * @Date: 2025-03-14 19:17:24
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-03-14 19:43:53
 * @FilePath: \react-official-website\src\components\app-footer\index.tsx
 */
import React, { memo } from 'react'
import type { FC, ReactNode } from 'react'
import { AppFooterWrapper } from '@/components/app-footer/style'
import footerData from '@/assets/data/footer.json'

interface IProps {
  children?: ReactNode
}

const AppFooter: FC<IProps> = () => {
  return (
    <AppFooterWrapper>
      <div className="wrapper">
        <div className="service">
          {footerData.map((item) => {
            return (
              <div className="item" key={item.name}>
                <div className="name">{item.name}</div>
                <div className="list">
                  {item.list.map((iten) => {
                    return (
                      <div className="iten" key={iten}>
                        {iten}
                      </div>
                    )
                  })}
                </div>
              </div>
            )
          })}
        </div>
        <div className="statement">© 2025 LPT 开发团队</div>
      </div>
    </AppFooterWrapper>
  )
}

export default memo(AppFooter)
