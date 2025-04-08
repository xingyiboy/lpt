/*
 * @Date: 2025-03-14 18:17:53
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-04-08 10:09:56
 * @FilePath: \react-official-website\src\store\index.ts
 */
import { configureStore } from '@reduxjs/toolkit'
import {
  shallowEqual,
  useDispatch,
  useSelector,
  type TypedUseSelectorHook
} from 'react-redux'
import mainReducer from './modules/main'
import docsReducer from './modules/docs'

const store = configureStore({
  reducer: {
    main: mainReducer,
    docs: docsReducer
  }
})

type RootState = ReturnType<typeof store.getState>
type DispatchType = typeof store.dispatch

export const useAppSelector: TypedUseSelectorHook<RootState> = useSelector
export const useAppDispatch: () => DispatchType = useDispatch
export const shallowEqualApp = shallowEqual

export default store
