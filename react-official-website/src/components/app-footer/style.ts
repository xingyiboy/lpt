import styled from 'styled-components'

export const AppFooterWrapper = styled.div`
  padding-top: 100px;
  border-top: 1px solid #ebebeb;
  background-color: #f8fbfd;
  width: 100%;

  .wrapper {
    width: 1080px;
    margin: 0 auto;
    box-sizing: border-box;
    padding: 48px 24px;
  }

  .service {
    display: flex;
    justify-content: center;
    .item {
      margin: 0 9%;
      display: inline-flex;
      flex-direction: column;

      .name {
        margin-bottom: 16px;
        font-weight: 700;
      }

      .list {
        font-weight: 600;

        .iten {
          margin-top: 10px;
          color: #767676;
          cursor: pointer;

          &:hover {
            text-decoration: underline;
          }
        }
      }
    }
  }

  .statement {
    margin-top: 30px;
    border-top: 1px solid #ebebeb;
    padding: 20px;
    color: #767676;
    text-align: center;
  }
`
