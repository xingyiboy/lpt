import { createSlice } from '@reduxjs/toolkit'

type InitialState = {
  theme: string
}

const initialState: InitialState = {
  theme: 'reading'
}
const docsSlice = createSlice({
  name: 'main',
  initialState,
  reducers: {
    changeTheme(state, { payload }) {
      state.theme = payload
    }
  }
})

export const { changeTheme } = docsSlice.actions
export default docsSlice.reducer
