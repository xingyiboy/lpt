/*
 * @Date: 2025-03-14 18:17:52
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-03-14 19:19:08
 * @FilePath: \react-official-website\src\App.tsx
 */
import React, { memo } from 'react'
import type { FC, ReactNode } from 'react'
import { useRoutes } from 'react-router-dom'
import routes from '@/router'
import AppHeader from '@/components/app-header'
import { useScrollTop } from '@/hooks'
import { GlobalStyle } from './views/docs/style'

interface IProps {
  children?: ReactNode
}

const App: FC<IProps> = () => {
  /** 切换路由时滚到页面顶部 */
  useScrollTop()

  return (
    <>
      <GlobalStyle />
      <div className="app">
        <AppHeader />
        <div style={{ width: '100%' }}>{useRoutes(routes)}</div>
      </div>
    </>
  )
}

export default memo(App)
