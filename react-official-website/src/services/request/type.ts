import type {
  AxiosRequestConfig,
  AxiosResponse,
  InternalAxiosRequestConfig
} from 'axios'

// 针对AxiosRequestConfig配置进行扩展
interface HXInterceptors<T = any> {
  requestSuccessFn?: (
    config: InternalAxiosRequestConfig
  ) => InternalAxiosRequestConfig
  requestFailureFn?: (err: any) => any
  responseSuccessFn?: (res: T) => T
  responseFailureFn?: (err: any) => any
}

// 修改这里，使用 Partial<InternalAxiosRequestConfig> 使所有属性变为可选
interface HXRequestConfig<T = any> extends Partial<InternalAxiosRequestConfig> {
  interceptors?: HXInterceptors<T>
}

export type { HXRequestConfig, HXInterceptors }
