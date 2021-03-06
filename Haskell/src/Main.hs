module Main where

import System.Exit
import Util
import MainProject
import PersistenceProject
import System.Directory

receiverProjectsData :: IO()
receiverProjectsData = do
    putStrLn "Digite o nome do projeto: "
    name <- getLine

    putStrLn "Digite a descrição do projeto: "
    description <- getLine

    putStrLn "Digite os responsaveis pelo projeto: "
    responsible <- getLine

    putStrLn "Digite a previsao de termino (em horas): "
    duration <- getLine

    if name /= "" then do
        let status = "A fazer"
        x <- getDirectoryContents "Projects"

        if  name `elem` x then do
            putStrLn "\n\nProjeto ja existe!\n"
            concludeScreenFail("cadastro")
        else do
            persistirProjeto name description responsible status (read duration)
            concludeScreen("cadastro")
        main
    else do
        putStrLn "\n\nDigite um nome valido!\n"
        concludeScreenFail("cadastro")
        main

listProjects :: IO()
listProjects = do
    x <- getDirectoryContents "Projects"
    putStrLn "\nProjetos existentes: "
    if length( x ) > 2 then 
        listNames x 1 0
    else
        putStrLn "- Não há projetos cadastrados.\n"

goToProject :: String -> IO()
goToProject pName = do
    x <- getDirectoryContents "Projects"
    if ((ehNumero pName) && (read pName :: Int) <= length (tiraPontos x) && (read pName :: Int) > 0)
        then do
            x <- getDirectoryContents "Projects"
            mainProject ( (tiraPontos x) !! ((read pName :: Int) - 1) )
	else do
		putStrLn "\nO projeto selecionado não existe!"
		putStrLn "Pressione a tecla Enter para voltar."
		getLine
		putStr ""


selectProject :: IO()
selectProject = do
	listProjects

	putStrLn "Digite o nome do projeto que você deseja selecionar: "
	projectName <- getLine

	projectExists <- doesDirectoryExist ("Projects/" ++ projectName)

	if projectExists then
		mainProject projectName
	else do
		goToProject projectName
	
	main

concludeProject :: IO()
concludeProject = do
    listProjects

    putStrLn "Digite o nome do projeto que você deseja concluir: "
    projectName <- getLine
    
    projectExists <- doesDirectoryExist ("Projects/" ++ projectName)

    if projectExists then do
        setStatusProjeto projectName "Concluido"
        putStrLn "Projeto concluído com sucesso!"
    else
        putStrLn "\nO projeto selecionado não existe!"

    putStrLn "\nPressione a tecla Enter para voltar."
    getLine

    main

main :: IO()
main = do
    criaDiretorio ("Projects")
    clear
    putStrLn "TODOL \n"
    putStrLn "1. Criar Projeto"
    putStrLn "2. Selecionar Projeto"
    putStrLn "3. Concluir projeto"
    putStrLn "0. Sair"
    putStr "Escolha: \n"
    choice <- getLine
    case choice of
        "1" -> receiverProjectsData
        "2" -> selectProject
        "3" -> concludeProject
        "0" -> returnScreen
        _   -> main
