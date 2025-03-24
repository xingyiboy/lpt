import { useState, useEffect } from 'react'

type ThemeType = 'light' | 'dark' | 'reading'

export const useTheme = () => {
  const [theme, setTheme] = useState(
    () => localStorage.getItem('theme') || 'light'
  )

  useEffect(() => {
    localStorage.setItem('theme', theme)
  }, [theme])

  return { theme, setTheme }
}
