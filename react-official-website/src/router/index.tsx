import React from 'react'
import { Navigate, type RouteObject } from 'react-router-dom'

const Home = React.lazy(() => import('@/views/home'))
const Docs = React.lazy(() => import('@/views/docs'))

const routes: RouteObject[] = [
  {
    path: '/',
    element: <Navigate to="/home" />
  },
  {
    path: '/home',
    element: <Home />
  },
  {
    path: '/docs/*',
    element: <Docs />
  },
  {
    path: '*',
    element: <Navigate to="/home" />
  }
]

export default routes
