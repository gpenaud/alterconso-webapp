package tools;


/**
    Helps to synchronize a list of objects.
    Typically updating a list of models from a web form.
    - create new entities from the source
    - update existing entities
    - delete entities which are not present in the source 

**/
class ListSynchronizer<Source,Destination>{

    var sourceDatas:Array<Source>;
    var destinationDatas:Array<Destination>;

    //functions to fill
    public var createNewEntity : Source->Destination;
    public var updateEntity : Source->Destination->Destination;
    public var deleteEntity : Destination->Void;
    public var isEqualTo : Source->Destination->Bool;

    public function new(){

    }

    public function setSourceDatas(sourceDatas:Array<Source>){
        this.sourceDatas = sourceDatas;
    }

    public function setDestinationDatas(destinationDatas:Array<Destination>){
        this.destinationDatas = destinationDatas;
    }

    public function sync(){
        
        var newEntitiesList = [];

        for(s in sourceDatas){
            var existing = Lambda.find(destinationDatas,function(d)return isEqualTo(s,d));
            if(existing!=null){
                //update
                existing = updateEntity(s,existing);
                destinationDatas.remove(existing);
            }else{
                //create
                existing = createNewEntity(s);
                
            }
            newEntitiesList.push(existing);
        }

        //delete remaining entities
        for( d in destinationDatas){
            deleteEntity(d);
        }


        destinationDatas = newEntitiesList;
        return destinationDatas;

    }

    


}