public class MyCustomException extends Exception {
    
    public override string getMessage(){
        return 'This is from My Custom Exception - method';
    }

}