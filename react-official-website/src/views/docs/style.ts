import styled, { createGlobalStyle } from 'styled-components'

export const DocWrapper = styled.div`
  min-height: 100vh;
  background: ${(props) => (props.theme === 'dark' ? '#1f1f1f' : '#f5f7f9')};
`

export const Header = styled.header`
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 24px;
  height: 70px;
  background: white;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1000;
`

export const Logo = styled.img`
  height: 32px;
`

export const Title = styled.h1`
  font-size: 18px;
  margin: 0;
  color: #333;
`

export const SearchBar = styled.div`
  position: relative;
  width: 200px;

  input {
    width: 100%;
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    outline: none;

    &:focus {
      border-color: #1890ff;
    }
  }
`

export const NavLinks = styled.nav`
  display: flex;
  gap: 24px;

  a {
    color: #666;
    text-decoration: none;

    &:hover {
      color: #1890ff;
    }
  }
`

export const MainContent = styled.div`
  display: grid;
  grid-template-columns: 280px 1fr 240px;
  gap: 24px;
  margin-top: 40px;
  padding: 0 24px 24px 24px;
  max-width: 1400px;
  margin-left: auto;
  margin-right: auto;
`

export const Sidebar = styled.aside<{ show: boolean }>`
  display: ${(props) => (props.show ? 'block' : 'none')};
  background: white;
  border-radius: 4px;
  padding: 16px;
  height: calc(100vh - 112px);
  position: sticky;
  top: 88px;
  overflow-y: auto;
`

export const Content = styled.main`
  background: white;
  border-radius: 4px;
  padding: 24px;
  min-height: calc(100vh - 112px);

  .main-title {
    font-size: 2rem;
    color: #333;
    margin-bottom: 2rem;
    padding-bottom: 1rem;
    border-bottom: 2px solid #eee;
  }

  .section-title {
    font-size: 1.5rem;
    color: #2c3e50;
    margin: 2rem 0 1rem;
    padding-top: 1rem;
    border-top: 1px solid #eee;
  }

  .content-paragraph {
    font-size: 1rem;
    line-height: 1.8;
    color: #444;
    margin: 1rem 0;
    text-align: justify;
  }

  .image-container {
    margin: 2rem 0;
    text-align: center;

    img {
      max-width: 100%;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }
  }

  .video-container {
    margin: 2rem 0;
    text-align: center;

    video {
      max-width: 100%;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }
  }

  a {
    color: #1890ff;
    text-decoration: none;
    transition: all 0.3s;

    &:hover {
      text-decoration: underline;
    }
  }

  .ql-code-block-container {
    a {
      color: #1890ff;
      text-decoration: none;
      transition: all 0.3s;

      &:hover {
        text-decoration: underline;
      }
    }
  }
`

export const RightSidebar = styled.aside`
  background: white;
  border-radius: 4px;
  padding: 16px;
  height: fit-content;
  position: sticky;
  top: 88px;
  margin-left: 20px;
  width: 180px;

  .toc-title {
    font-size: 1.2rem;
    color: #333;
    margin-bottom: 1rem;
    padding-bottom: 0.5rem;
    border-bottom: 1px solid #eee;
  }

  .toc-list {
    list-style: none;
    padding: 0;
  }

  .toc-item {
    font-size: 0.9rem;
    color: #666;
    padding: 0.5rem 0;
    cursor: pointer;
    transition: color 0.3s;

    &:hover {
      color: #1890ff;
    }
  }

  ul {
    list-style: none;
    padding: 0;
    margin: 0;

    li {
      padding: 8px 0;
      color: #666;
      cursor: pointer;

      &:hover {
        color: #1890ff;
      }
    }
  }
`

export const FloatingButtons = styled.div`
  position: fixed;
  bottom: 2rem;
  right: 2rem;
  display: flex;
  flex-direction: column;
  gap: 1rem;
  z-index: 1000;
`

export const IconButton = styled.button`
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: white;
  border: none;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  position: relative;
  color: #666;
  transition: all 0.3s;

  &:hover {
    background: #f5f5f5;
    transform: translateY(-2px);
  }
`

export const ThemeDropdown = styled.div<{ show: boolean }>`
  position: absolute;
  bottom: 100%;
  right: 0;
  margin-bottom: 8px;
  background: white;
  border-radius: 20px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
  display: ${(props) => (props.show ? 'flex' : 'none')};
  flex-direction: column;
  gap: 8px;
  padding: 8px;
`

export const ThemeOption = styled.div<{ active: boolean }>`
  width: 32px;
  height: 32px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  background: ${(props) => (props.active ? '#f0f7ff' : 'transparent')};
  color: ${(props) => (props.active ? '#1890ff' : '#666')};

  &:hover {
    background: #f5f5f5;
  }
`

export const SidebarSection = styled.div`
  margin-bottom: 1.5rem;
`

export const SectionTitle = styled.h3`
  margin: 0 0 0.5rem;
  font-size: 1rem;
  color: #666;
`

export const SidebarItem = styled.div<{ active?: boolean }>`
  padding: 0.5rem 1rem;
  cursor: pointer;
  color: ${(props) => (props.active ? '#0066cc' : 'inherit')};
  background: ${(props) => (props.active ? '#f0f7ff' : 'transparent')};
  border-radius: 4px;

  &:hover {
    background: #f5f5f5;
  }
`

export const RightSidebarItem = styled(SidebarItem)`
  font-size: 0.9rem;
  padding: 0.25rem 0.5rem;
`

export const ToggleSidebarButton = styled(IconButton)`
  margin-left: 1rem;
`

export const GlobalStyle = createGlobalStyle`
  body[data-theme='light'] {
    background-color: #f5f7f9;
  }

  body[data-theme='dark'] {
    background-color: #1f1f1f;
    color: #e5eaf3;

    ${DocWrapper} {
      background: #1f1f1f;
    }

    ${Header} {
      background: #2d2d2d;
      box-shadow: none;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    ${Title} {
      color: #e5eaf3;
    }

    ${SearchBar} input {
      background: #2d2d2d;
      border-color: #444;
      color: #e5eaf3;

      &::placeholder {
        color: #888;
      }
    }

    ${NavLinks} a {
      color: #e5eaf3;

      &:hover {
        color: #1890ff;
      }
    }

    ${Sidebar}, ${Content}, ${RightSidebar} {
      background: #2d2d2d;
      color: #e5eaf3;
    }

    ${Content} {
      .main-title {
        color: rgba(255, 255, 255, 0.85);
        border-bottom: 2px solid rgba(255, 255, 255, 0.1);
      }

      .section-title {
        color: rgba(255, 255, 255, 0.85);
        border-top: 1px solid rgba(255, 255, 255, 0.1);
      }

      .content-paragraph {
        color: rgba(255, 255, 255, 0.85);
      }

      a {
        color: #1890ff;
      }
    }

    ${SidebarItem} {
      color: rgba(255, 255, 255, 0.85);

      &:hover {
        background: #363636;
      }

      &[active=true] {
        background: #363636;
        color: #1890ff;
      }
    }

    ${RightSidebar} {
      .toc-title {
        color: rgba(255, 255, 255, 0.85);
      }

      .toc-item {
        color: rgba(255, 255, 255, 0.85);
      }

      ul li {
        color: rgba(255, 255, 255, 0.85);
      }
    }

    ${IconButton} {
      background: #2d2d2d;
      color: #888;

      &:hover {
        background: #363636;
      }
    }

    ${ThemeDropdown} {
      background: #2d2d2d;
    }

    ${ThemeOption} {
      color: #888;

      &:hover {
        background: #363636;
      }

      &[active=true] {
        background: #363636;
        color: #1890ff;
      }
    }
  }

  body[data-theme='reading'] {
    background-color: #fdf6e3;
    color: #333;

    ${DocWrapper} {
      background: #fdf6e3;
    }

    ${Header} {
      background: #fef8e7;
      box-shadow: none;
      border-bottom: 1px solid rgba(0, 0, 0, 0.1);
    }

    ${Content} {
      background: #fef8e7;
      color: #333;
      line-height: 1.8;
      font-size: 16px;
    }

    ${Sidebar}, ${RightSidebar} {
      background: #fef8e7;
    }

    ${SidebarItem} {
      color: #586e75;

      &:hover {
        background: #eee8d5;
      }

      &[active=true] {
        background: #eee8d5;
        color: #b58900;
      }
    }

    ${IconButton} {
      background: #fef8e7;
      color: #586e75;

      &:hover {
        background: #eee8d5;
      }
    }

    ${ThemeDropdown} {
      background: #fef8e7;
    }
  }
`
