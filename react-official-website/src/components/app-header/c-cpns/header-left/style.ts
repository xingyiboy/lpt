import styled from 'styled-components'

export const LeftWrapper = styled.div`
  flex: 1;
  display: flex;
  align-items: center;
  color: ${(props) => props.theme.color.primaryColor};

  .logo {
    cursor: pointer;

    img {
      width: 102px;
      height: 52px;
      margin-left: 24px;
      vertical-align: middle;
    }
  }
`
