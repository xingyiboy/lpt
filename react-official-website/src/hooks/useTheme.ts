import { useState, useEffect } from 'react'

type ThemeType = 'light' | 'dark' | 'reading'

export const useTheme = () => {
  const [theme, setTheme] = useState<ThemeType>('light')

  useEffect(() => {
    const savedTheme = localStorage.getItem('theme') as ThemeType
    if (savedTheme) {
      setTheme(savedTheme)
    }
  }, [])

  const updateTheme = (newTheme: ThemeType) => {
    setTheme(newTheme)
    localStorage.setItem('theme', newTheme)
  }

  return { theme, setTheme: updateTheme }
}
