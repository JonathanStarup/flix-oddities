mod Struct {

    mod WithRecords {
        pub type alias NodeRecord[t: Type, r: Region] = {
            data = Ref[t, r],
            // mut data = t,
            prev = Ref[Option[Node[t, r]], r],
            next = Ref[Option[Node[t, r]], r]
        }

        pub enum Node[t: Type, r: Region](NodeRecord[t, r])

        pub def getNext(node: Node[t, r]): Option[Node[t, r]] \ r = {
            let Node.Node(rec) = node;
            deref rec.next
        }
        pub def setNext(x: Option[Node[t, r]], node: Node[t, r]): Unit \ r = {
            let Node.Node(rec) = node;
            rec.next := x
        }
        // etc ...
    }

    mod WithTuples {

// pub struct Node[t: Type, r: Region] {
//     mut data = t,
//     mut prev: Option[Node[t, r]],
//     mut next: Option[Node[t, r]],
//     id: Int32
// }
pub enum Node[t: Type, r: Region](
    Ref[t, r],                  // data
    Ref[Option[Node[t, r]], r], // prev
    Ref[Option[Node[t, r]], r], // next
    Int32
)

// (node: Node[t, r]).next ===== getNext(node)
pub def getNext(node: Node[t, r]): Option[Node[t, r]] \ r = {
    let Node.Node(_, _, next, _) = node;
    deref next
}

// (node: Node[t, r]).next := None ===== setNext(node, None)
pub def setNext(node: Node[t, r], x: Option[Node[t, r]]): Unit \ r = {
    let Node.Node(_, _, next, _) = node;
    next := x
}
// etc ...

    }

}
