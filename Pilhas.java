package javaapplication3;

public class Pilhas {
    
    private static final int max = 50;
    private int topo = -1;
    private char[] pilha = new char[max];
    private char temp;
     
    public Pilhas(){
        this.topo = -1;
    }
     
    public boolean isFull(){
        return this.topo == max-1;
    }
     
    public boolean isEmpty(){
        return this.topo == -1;
    }

    public void push(char elemento){
        if (!this.isFull()){
            topo++;
            pilha[topo] = elemento;
        }
        else
            System.out.println("Pilha cheia!");
     }
    
    public char pop(){
        if (!this.isEmpty()){
            temp = pilha[topo];
            pilha[topo] = '\0';
            topo--;
            return temp;
        }
        else{
            System.out.println("Pilha vazia!");
            return '\0';
        }
     }
    
    public char top(){
        if (!this.isEmpty()){
            return this.pilha[this.topo];
        }
        else{
            System.out.println("Pilha vazia!");
            return '\0';
        }
     }
}
    