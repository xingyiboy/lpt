/*
 * @Date: 2025-03-14 19:17:24
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-03-24 22:23:25
 * @FilePath: \react-official-website\src\components\app-header\c-cpns\header-right\index.tsx
 */
import React, { memo, useEffect, useState } from 'react'
import type { FC, ReactNode } from 'react'
import { RightWrapper } from '@/components/app-header/c-cpns/header-right/style'
import IconMenu from '@/assets/svg/icon_menu'
import IconGlobal from '@/assets/svg/icon_global'
import IconAvatar from '@/assets/svg/icon_avatar'

interface IProps {
  children?: ReactNode
}

const HeaderRight: FC<IProps> = () => {
  const [showPanel, setShowPanel] = useState(false)
  useEffect(() => {
    const windowHandleClick = () => {
      setShowPanel(false)
    }
    window.addEventListener('click', windowHandleClick, true)
    return () => {
      window.removeEventListener('click', windowHandleClick, true)
    }
  }, [])

  const profileClickHandle = () => {
    setShowPanel(true)
  }
  // 跳转函数
  const handleInterfaceClick = () => {
    window.open('http://113.45.31.128:99/user/login', '_blank') // _blank 会在新标签页中打开
  }

  const handleOnlineClick = () => {
    window.open('https://113.45.31.128', '_blank') // _blank 会在新标签页中打开
  }

  const handleDocsClick = () => {
    window.location.href = '/docs'
  }

  return (
    <RightWrapper>
      <div className="btns">
        <span className="btn" onClick={handleDocsClick}>
          开发指南
        </span>
        <span className="btn" onClick={handleInterfaceClick}>
          接口系统
        </span>
        <span className="btn" onClick={handleOnlineClick}>
          在线体验
        </span>
        <span className="btn">GitHub</span>
      </div>
    </RightWrapper>
  )
}

export default memo(HeaderRight)
