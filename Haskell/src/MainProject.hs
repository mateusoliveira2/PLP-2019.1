module MainProject where
import System.Exit
import MainTodo
import MainFilter
import Util

editToDo :: String -> IO()
editToDo projectName = do
    clear
    -- mostrar todas ToDos
    putStrLn "Digite o nome da ToDo: "
    todoName <- getLine
    --verificar validade

    mainTodo projectName todoName
    
filterTodo :: String -> IO()
filterTodo projectName = mainFilter projectName

mainProject :: String -> IO()
mainProject projectName = do 
    clear
    putStrLn projectName 
    putStrLn "1. Criar ToDo"
    putStrLn "2. Editar ToDo"
    putStrLn "3. Listar ToDo"
    putStrLn "4. Filtrar ToDo"
    putStrLn "5. Gerar Relatorio"
    putStrLn "6. Editar Nome do Projeto"
    putStrLn "0. Sair"
    putStrLn "Escolha: "
    choice <- getLine

    case choice of
               "1" -> putStrLn "ok" 
               "2" -> editToDo projectName
               "3" -> putStrLn "ok"
               "4" -> filterTodo projectName
               "5" -> putStrLn "ok"
               "6" -> putStrLn "ok"
               "0" -> returnScreen
               _   -> mainProject projectName