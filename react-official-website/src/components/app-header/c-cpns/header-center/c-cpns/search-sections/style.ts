/*
 * @Date: 2025-03-14 19:17:24
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-03-14 21:18:42
 * @FilePath: \react-official-website\src\components\app-header\c-cpns\header-center\c-cpns\search-sections\style.ts
 */
import styled from 'styled-components'

export const SectionsWrapper = styled.div`
  position: absolute;
  top: 10px;
  left: 50%;
  transform: translateX(-50%);
  width: 850px;
  border-radius: 12px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  z-index: 999;

  .content {
    padding: 20px;
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 12px;
  }

  .item {
    display: flex;
    flex-direction: column;
    cursor: pointer;
    padding: 12px;
    border-radius: 8px;
    transition: all 0.2s;

    .info {
      .title {
        font-size: 14px;
        font-weight: 600;
        color: #fff;
        margin-bottom: 4px;
      }

      .desc {
        font-size: 12px;
        color: #f5f5f5;
      }
    }

    &:hover {
      background-color: #1f1f1f;
      transform: translateY(-2px);
    }
  }
`
