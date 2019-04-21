/*
	Main da aplicacao.
	Controlla o loop principal e a entrada e saida de dados 
	no menu principal para o usuario.
*/

#include <cstdio>
#include <cstdlib>
#include <stdio_ext.h> 
#include "projectController.cpp"

void selectProject(){
	char projectName[20];
	
	printf("\n\tDIGITE O NOME DO PROJETO: ");
	gets(projectName);
	
	system("clear");
	
	//verificacao que existe para poder ir pra o projectMain

	projectMain(projectName);
}

void sendProject(){
	char projectName[30], description[100], responsible[100];
	int prevision;
	
	printf("\n\tDIGITE O NOME DO PROJETO: ");
	gets(projectName);
	
		
	printf("\n\tDIGITE A DESCRICAO DO PROJETO: ");
	gets(description);

	printf("\n\tDIGITE OS RESPONSAVEIS PELO DO PROJETO: ");
	gets(responsible);
	
	printf("\n\tDIGITE A PREVISAO DE TERMINO: ");
	scanf("%d", &prevision);
	
	
	createProject(projectName, description, responsible, prevision);

	conclusionScreen("Projeto criado");
}

void concludeProject(){
	char projectName[20];
	printf("\n\tDIGITE O NOME DO PROJETO: ");
	gets(projectName);

	//chama setStatus de projeto
	conclusionScreen("Conclusao feita");
}

int main () {
	int choice;

    do {
        printf("\n\tTODOL\n\n");
        printf("\t1. Criar Projeto\n");
        printf("\t2. Selecionar Projeto\n");
        printf("\t3. Concluir projeto\n");
        printf("\t0. Sair\n\n");
        printf("\tESCOLHA: ");

        scanf("%d", &choice);
        fflush(stdin);
		__fpurge(stdin);
		system("clear");
        switch(choice){
            case 1:
                sendProject();
                break;

            case 2:
                selectProject();
                break;

            case 3:
                concludeProject();
                break;

            case 0:
                break;

            default:
                printf("Digite uma opcao valida\n");
        }
        
    } while(choice);
	
	return 0;
}
