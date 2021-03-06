:- use_module(menuProject).
:- use_module(persistenceProject).
:- use_module(utils).
:-initialization (main). 
    
menu:-repeat,
    write("\n\n-------TODOL-------"),nl,
    write("1. Criar Projeto\n"),
    write("2. Selecionar Projeto\n"),
    write("3. Concluir projeto\n"),
    write("0. Sair\n\n"),nl,
    write("ESCOLHA: "),nl,
    read_line_to_string(user_input, Choice),
        
    ( Choice = "0" -> !, fail ; true ),
    ( Choice = "1" -> receiverProjectsData; true),
    ( Choice = "2" -> selectProject;
      Choice = "3" -> concludeProject),
    
    fail.

receiverProjectsData:-
    write("\n\n-------CRIAR PROJETO-------\n"),
    write("Digite o nome do projeto: \n"),
	read_line_to_string(user_input, ProjectName),
    write("Digite a descrição do projeto: \n"),
	read_line_to_string(user_input, Description),
    write("Digite os responsaveis pelo projeto: \n"),
	read_line_to_string(user_input, Responsible),
    write("Digite a previsao de termino (em horas): \n"),
	read_line_to_string(user_input, Duration),
    persistirProjeto(ProjectName, Description, Responsible, "A Fazer", Duration),
    menu.

selectProject:-
    allProjectsList(Projects),
    length(Projects, SizeList),
    (SizeList > 2) -> (
        write("\n-------SELECIONAR PROJETO-------\n"),
        showExistentProjects(Projects),
        write("Digite o nome do projeto a ser selecionado: \n"),
        read_line_to_string(user_input, ProjectName),
        ( projectExists(ProjectName) -> (
            write(ProjectName), write(' selecionado com sucesso!\n'),
            menuProject(ProjectName)
        );
        write("\nO projeto selecionado não existe!\n") )
    ); 
    write("\nNão há projetos a serem selecionados! Escolha outra opção.\n"), 
    main.

concludeProject:-
    allProjectsList(Projects),
    length(Projects, SizeList),
    (SizeList > 2) -> (
        write("\n\n-------CONCLUIR PROJETO-------\n"),
        showExistentProjects(Projects),
        write("Digite o nome do projeto: \n"),
        read_line_to_string(user_input, ProjectName),
        ( projectExists(ProjectName) ->  write(ProjectName), write(' concluido com sucesso!\n');
        write("\nO projeto selecionado não existe!\n") )
    ); 
    write("\nNão existem projetos a serem concluídos. Escolha outra opção.\n"),
    main.

main :- 
    menu.
