public class DataWrapperClass {
	public integer distance;
    public string emailAddress;
    public string firstName;
    public string headLine;
    public string lastName;
    public string pictureURL;
    public positionClass positions;
    public string publicProfileURL;
    
    public class positionClass{
        public integer total;
        public valueClass[] values;				// public list<valueClass> values;
    }
    
    public class valueClass{
        public companyClass company;
        public integer id;
        public string isCurrent;
        public locationClass location;
        public string title;
        
    }
    
    public class locationClass{
        public string latitude;
        public string longitude;
    }
    
    public class companyClass{
        public integer id;
        public string industry;
        public string name;
        public string size;
        public string ticker;
        public string type1;
    }
}