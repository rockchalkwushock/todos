import '../styles/globals.css'
import type { AppProps } from 'next/app'
import { DataClient, DataDevtools, DataProvider } from '@services/data'
import { useRef } from 'react'

function MyApp({ Component, pageProps, router }: AppProps) {
  const clientRef = useRef<DataClient>()

  if (!clientRef.current) {
    clientRef.current = new DataClient()
  }
  return (
    <DataProvider client={clientRef.current}>
      <Component {...pageProps} key={router.asPath} query={router.query} />
      <DataDevtools />
    </DataProvider>
  )
}

export default MyApp
