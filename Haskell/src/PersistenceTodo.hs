module PersistenceTodo where

import System.IO
import System.IO.Unsafe
import System.Directory
import Data.List.Split

-- alteraLista :: [t] -> Int -> t -> [t]
-- alteraLista lista indice elemento = (take (indice - 1) lista) ++ [elemento] ++ (drop indice lista)


removeArquivo :: String -> IO()
removeArquivo nome = do
    success <- doesFileExist nome
    
    if success 
    then removeFile nome
    else return ()


persistirTodo :: String -> String -> String -> String -> String -> String -> String -> IO()
persistirTodo nomeProjeto nome descricao responsavel status previsao horas = do
    let nomeDiretorio = "Projects/" ++ nomeProjeto ++ "/"
    let conteudoTodo = nome ++ "\n" ++ descricao ++ "\n" ++ responsavel ++ "\n" 
							++ status ++ "\n" ++ previsao ++ "\n" ++ horas ++ "\n"
    
    removeArquivo (nomeDiretorio ++ nome ++ ".txt") 
    
    writeFile (nomeDiretorio ++ nome ++ ".txt") (conteudoTodo)

setNomeTodo :: String -> String -> String -> IO()
setNomeTodo nomeProjeto nome novoNome = do
    let todo = returnTodo nomeProjeto nome
    let nomeDiretorio = "Projects/" ++ nomeProjeto ++ "/"
    persistirTodo nomeProjeto novoNome (todo !! 1) (todo !! 2) (todo !! 3) (todo !! 4) (todo !! 5)
    removeArquivo (nomeDiretorio ++ nome ++ ".txt")

setDescricaoTodo :: String -> String -> String -> IO()
setDescricaoTodo nomeProjeto nome descricao = do
    let todo = returnTodo nomeProjeto nome
    persistirTodo nomeProjeto (todo !! 0) descricao (todo !! 2) (todo !! 3) (todo !! 4) (todo !! 5)

setResponsavelTodo :: String -> String -> String -> IO()
setResponsavelTodo nomeProjeto nome responsavel = do
    let todo = returnTodo nomeProjeto nome
    persistirTodo nomeProjeto (todo !! 0) (todo !! 1) responsavel (todo !! 3) (todo !! 4) (todo !! 5)

setStatusTodo :: String -> String -> String -> IO()
setStatusTodo nomeProjeto nome status = do
    let todo = returnTodo nomeProjeto nome
    persistirTodo nomeProjeto (todo !! 0) (todo !! 1) (todo !! 2) status (todo !! 4) (todo !! 5)

addHorasTrabalhadas :: String -> String -> Int -> IO()
addHorasTrabalhadas nomeProjeto nome horas = do
    let todo = returnTodo nomeProjeto nome
    let horasFinais = (show (horas + (read (todo !! 5)) :: Int))
    persistirTodo nomeProjeto (todo !! 0) (todo !! 1) (todo !! 2) (todo !! 3) (todo !! 4) horasFinais

getStatus :: String -> String -> String
getStatus nomeProjeto nome = (returnTodo nomeProjeto nome)!!3

getHorasTrabalhadas :: String -> String -> String
getHorasTrabalhadas nomeProjeto nome = (returnTodo nomeProjeto nome)!!4

readTodo :: String -> String -> IO String
readTodo nomeProjeto nomeTodo = do
    let nome = ("Projects/" ++ nomeProjeto ++ "/" ++ nomeTodo)
    readFile (nome ++ ".txt")

returnTodo :: String -> String -> [String]
returnTodo nomeProjeto nome = do
    let contents = unsafePerformIO $ readTodo nomeProjeto nome
    lines contents

returnAllTodosName :: String -> [String]
returnAllTodosName projectName = do
    let contents = unsafePerformIO $ getDirectoryContents ("Projects/" ++ projectName)
    x <- contents
    lines x

returnAllTodosContent :: String -> [[String]]
returnAllTodosContent projectName = do
    let lista = returnAllTodosName projectName
    adicionaLista projectName lista

teste :: String -> String
teste x = (splitOn "." x) !! 0

adicionaLista :: String -> [String] -> [[String]]
adicionaLista projectName [] = []
adicionaLista projectName (x:xs)
    |x == "." || x == ".." || x == projectName || (x!!0) == '.' = adicionaLista projectName xs
    |xs == [] = [(returnTodo projectName (teste x))]
    |otherwise = (returnTodo projectName (teste x)):(adicionaLista projectName xs)
