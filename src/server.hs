import Network.Socket
import System.IO
import Control.Monad (unless, forever)
import System.Environment (lookupEnv)
import System.Exit (die)

main :: IO ()
main = withSocketsDo $ do
    maybePort <- lookupEnv "HTTP_SERVER_PORT"
    case maybePort of
        Nothing -> die "Environment variable HTTP_SERVER_PORT is not set."
        Just port -> do
            addr <- resolve port
            sock <- openLocalSocket addr
            putStrLn $ "Listening on port " ++ port ++ "..."
            forever $ do
                (conn, _peer) <- accept sock
                handleConn conn

resolve :: ServiceName -> IO AddrInfo
resolve port = do
    let hints = defaultHints { addrFlags = [AI_PASSIVE], addrSocketType = Stream }
    addr:_ <- getAddrInfo (Just hints) Nothing (Just port)
    return addr

openLocalSocket :: AddrInfo -> IO Socket
openLocalSocket addr = do
    sock <- socket (addrFamily addr) (addrSocketType addr) (addrProtocol addr)
    setSocketOption sock ReuseAddr 1
    bind sock (addrAddress addr)
    listen sock 10
    return sock

handleConn :: Socket -> IO ()
handleConn conn = do
    h <- socketToHandle conn ReadWriteMode
    hSetBuffering h LineBuffering
    request <- hGetLine h
    -- putStrLn $ "Received request: " ++ request
    unless (null request) $ do
        hPutStr h response
        hFlush h
    hClose h

response :: String
response = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World!"
