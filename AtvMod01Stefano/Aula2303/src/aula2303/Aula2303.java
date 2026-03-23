package aula2303;

    import java.util.LinkedList;
    import java.util.Scanner;

public class Aula2303 {
        
    public static void main(String[] args) {
    
        LisEnc lista1 = new LisEnc();
        int resp = 0;
        Scanner leitor = new Scanner(System.in);
                
        while (resp != 5){
            System.out.println("""
                               Escolha uma opcao:
                               [1] - Checar se a lista esta vazia
                               [2] - Acrescentar elemento ao final da lista
                               [3] - Remover primeiro elemento da lista
                               [4] - Exibir lista
                               [5] - Sair do programa
                               """);
            
            resp = leitor.nextInt();
        
            switch (resp){
                case 1 -> lista1.checkVazia();
            }
        }
    }
    
}
