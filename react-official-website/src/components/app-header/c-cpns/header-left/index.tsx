import React, { memo } from 'react'
import type { FC, ReactNode } from 'react'
import { useNavigate } from 'react-router-dom'
import { LeftWrapper } from '@/components/app-header/c-cpns/header-left/style'
import logo from '@/assets/img/logo.png'

interface IProps {
  children?: ReactNode
}

const HeaderLeft: FC<IProps> = () => {
  const navigate = useNavigate()
  function logoClickHandle() {
    navigate('/home')
  }

  return (
    <LeftWrapper>
      <div className="logo" onClick={logoClickHandle}>
        <img src={logo} alt="Logo" />
      </div>
    </LeftWrapper>
  )
}

export default memo(HeaderLeft)
