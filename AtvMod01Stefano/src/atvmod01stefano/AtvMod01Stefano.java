package atvmod01stefano;

import java.util.Random;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class AtvMod01Stefano {
    
    public static void main(String[] args) {
        
        int cont1, cont2, linMai = 0, colMai = 0, valMai = 0, sum = 0;    
        int[][] m1 = new int[7][5];
        int[][] m2 = new int[4][3];
        Random random = new Random();
        String[] cores1 = {"preto", "amarelo", "verde", "azul", "violeta", "prata"};
        String[] cores2 = {"dourado", "branco", "marrom", "azul", "cinza", "prata"};
        ArrayList<String> coresL1 = new ArrayList<>(Arrays.asList(cores1));
        ArrayList<String> coresL2 = new ArrayList<>(Arrays.asList(cores2));


        for (cont1 = 0; cont1 < 7; cont1++){
            for(cont2 = 0; cont2 <5; cont2++){
                m1[cont1][cont2] = random.nextInt(101);
            }
        }

        for (cont1 = 0; cont1 < 7; cont1++){
            sum = 0;
            for(cont2 = 0; cont2 <5; cont2++){
                System.out.print(m1[cont1][cont2] + "\t");
                sum += m1[cont1][cont2];
            }
            System.out.println("| Sum: " + sum);
        }
        
        for (cont1 = 0; cont1 < 4; cont1++){
            for(cont2 = 0; cont2 <3; cont2++){
                m2[cont1][cont2] = random.nextInt(101);
            }
        }
        
        for (cont1 = 0; cont1 < 4; cont1++){
            for(cont2 = 0; cont2 <3; cont2++){
                System.out.print(m2[cont1][cont2] + "\t");
                if (cont1 == 0 && cont2 == 0){
                    linMai = cont1;
                    colMai = cont2;
                    valMai = m2[cont1][cont2];
                }
                else if (m2[cont1][cont2] > valMai){
                    linMai = cont1;
                    colMai = cont2;
                    valMai = m2[cont1][cont2];
                }
            }
            System.out.println();
        }
        System.out.println("Maior valor encontrado: " + valMai);
        System.out.println("Valor encontrado na posição: " + linMai + "," + colMai);
        
        coresL1.addAll(coresL2);
        coresL2 = null;
    }
    
}