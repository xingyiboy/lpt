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
      <HomeBanner />
      <AppFooter />
    </HomeWrapper>
  )
}

export default memo(Home)
