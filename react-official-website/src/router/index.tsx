import React from 'react'
import { Navigate, type RouteObject } from 'react-router-dom'

const Home = React.lazy(() => import('@/views/home'))

const routes: RouteObject[] = [
  {
    path: '/',
    element: <Navigate to="/home" />
  },
  {
    path: '/home',
    element: <Home />
  }
]

export default routes
