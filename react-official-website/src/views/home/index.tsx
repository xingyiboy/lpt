/*
 * @Date: 2025-03-14 18:17:53
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-03-24 20:35:45
 * @FilePath: \react-official-website\src\views\home\index.tsx
 */
import React, { memo, useEffect } from 'react'
import type { FC, ReactNode } from 'react'
import { HomeWrapper } from '@/views/home/style'
import HomeBanner from '@/views/home/c-cpns/home-banner'
import { shallowEqualApp, useAppDispatch, useAppSelector } from '@/store'
import { isEmptyO } from '@/utils'
import AppFooter from '@/components/app-footer'
import { changeHeaderConfigAction } from '@/store/modules/main'

interface IProps {
  children?: ReactNode
}

const Home: FC<IProps> = () => {
  /** 派发异步事件：发送网络请求 */
  const dispatch = useAppDispatch()
  useEffect(() => {
    dispatch(changeHeaderConfigAction({ isFixed: true, topAlpha: true }))
  }, [dispatch])

  return (
    <HomeWrapper style={{ width: '100%' }}>
      <img
        src={require('@/assets/img/background.png')}
        style={{
          width: '100%',
          height: '100vh',
          objectFit: 'cover'
        }}
      />
      <AppFooter />
    </HomeWrapper>
  )
}

export default memo(Home)
