/*
	Main da aplicação.
	Controlla o loop principal e a entrada e saída de dados 
	no menu principal para o usuário.
*/

#include<stdio.h>
#include <stdlib.h>
#include "projectController.cpp"

void selecionarProjeto(){
	char nomeProjeto[20];
	
	printf("\n\tDIGITE O NOME DO PROJETO: ");
	scanf("%s", nomeProjeto);
	
	system("cls || clear");
	
	//verifica��o que existe para poder ir pra o projetoMenu
	projectMain(nomeProjeto);
}

void criarProjeto(){
	char nomeProjeto[20], descricao[100];
	int previsaoConclusao;
	
	
	printf("\n\tDIGITE O NOME DO PROJETO: ");
	scanf("%s", nomeProjeto);
	
		
	printf("\n\tDIGITE A DESCRI��O DO PROJETO: ");
	scanf("%s", descricao );
	
	printf("\n\tDIGITE A PREVIS�O DE TERMINO: ");
	scanf("%d", &previsaoConclusao);
	
	system("cls || clear");
	
	//fun��o de criar projeto com structs e arquivos.
}

void concluirProjeto(){
	char nomeProjeto[20];
	printf("\n\tDIGITE O NOME DO PROJETO: ");
	scanf("%s", nomeProjeto);
	
	system("cls || clear");

	//aqui ja viria o retorno da fun��o que exclui o arquivo.
}


int main () {
	int escolha=1;

    do{
    
        printf("\n\tTODOL\n\n");
        printf("\t1. Criar Projeto\n");
        printf("\t2. Selecionar Projeto\n");
        printf("\t3. Concluir projeto\n");
        printf("\t0. Sair\n\n");
        printf("\tESCOLHA: ");

        scanf("%d", &escolha);
		system("cls || clear");
        switch(escolha){
            case 1:
                criarProjeto();
                break;

            case 2:
                selecionarProjeto();
                break;

            case 3:
                concluirProjeto();
                break;

            case 0:
                break;

            default:
                printf("Digite uma opcao valida\n");
        }
        
    } while(escolha);
	
	
	return 0;
}
