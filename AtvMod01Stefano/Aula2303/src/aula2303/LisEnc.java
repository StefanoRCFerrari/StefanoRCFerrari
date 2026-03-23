package aula2303;

    import java.util.LinkedList;

public class LisEnc {
    
    private LinkedList<Integer> lisEnc = new LinkedList<>();
    
    public void addElem(int num){
        lisEnc.add(num);
    }
    
    public void remElem(LinkedList<Integer> LisEnc){
        if (!lisEnc.isEmpty())
            lisEnc.remove();
    }
    
    public void showList(LinkedList<Integer> LisEnc){
        for (int item : lisEnc){
            System.out.println(item);
        }
    }
    
    public boolean checkVazia(LinkedList<Integer> LisEnc){
        return lisEnc.isEmpty();
    }
}
