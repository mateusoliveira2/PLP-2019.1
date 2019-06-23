:- use_module(menuProject).

:-initialization (main). 
    
menu:-repeat,
        write("\n\n-------TODOL-------"),nl,
        write("1. Criar Projeto\n"),
        write("2. Selecionar Projeto\n"),
        write("3. Concluir projeto\n"),
        write("0. Sair\n\n"),nl,
        write("ESCOLHA: "),nl,
        read(Choice),
        
        ( Choice = 0 -> !, fail ; true ),
        ( Choice = 1 -> receiverProjectsData; true),
        ( Choice = 2 -> selectProject;
          Choice = 3 -> concludeProject),
        
        fail.

receiverProjectsData:-
        write("\n\n-------CRIAR PROJETO-------\n"),
        write("Digite o nome do projeto: \n"),
        read(ProjectName),
        write("Digite a descrição do projeto: \n"),
        read(Description),
        write("Digite os responsaveis pelo projeto: \n"),
        read(Responsible),
        write("Digite a previsao de termino (em horas): \n"),
        read(Duration),
        write(ProjectName),write(" ") , write(Description), write(" "),write(Responsible),
        write(" "), write(Duration),
        
        menu.

selectProject:-
        write("\n\n-------SELECIONAR PROJETO-------\n"),
        write("Digite o nome do projeto: \n"),
        read(ProjectName),
        write(ProjectName),write(' selecionado com sucesso!'),
        menuProject(ProjectName),

        menu.

concludeProject:-
        write("\n\n-------CONCLUIR PROJETO-------\n"),
        write("Digite o nome do projeto: \n"),
        read(ProjectName),
        write(ProjectName),write(' concluido com sucesso!').

        menu.

main :- 
    menu.
