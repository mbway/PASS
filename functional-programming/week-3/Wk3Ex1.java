
/**
 * Created by matthew on 26/10/15.
 */
public class Wk3Ex1 {

    public static class FiveTuple {
        // note: immutable
        public final int a;
        public final int b;
        public final int c;
        public final int d;
        public final int e;

        public FiveTuple(int setA, int setB, int setC, int setD, int setE) {
            a = setA;
            b = setB;
            c = setC;
            d = setD;
            e = setE;
        }

        @Override
        public String toString() {
            return "(" + a + ", " + b + ", " + c + ", " + d + ", " + e + ")";
        }

    }

    public static class Pair {
        // note: immutable
        public final int first;
        public final int second;

        public Pair(int setFirst, int setSecond) {
            first  = setFirst;
            second = setSecond;
        }
    }





    public static Pair sort2(Pair p) {
        if(p.first < p.second) {
            return new Pair(p.first, p.second); // no change, but create a new tuple
        }
        else {
            return new Pair(p.second, p.first); // elements swapped (create new tuple)
        }
    }

    public static FiveTuple singleBubble(FiveTuple t) {
        /*

           x --|-- box.first
               |
           y --|-- box.second

        Corresponds to the Java code:

            Pair box = sort2(new Pair(x, y));


        Single pass of bubble sort over the 5-tuple:

           a --|-----------  firstBox.first
               |
           b --|--|--------  secondBox.first
                  |
           c -----|--|-----  thirdBox.first
                     |
           d --------|--|--  fourthBox.first
                        |
           e------------|--  fourthBox.second

        */
        Pair firstBox  = sort2(new Pair(t.a,              t.b));
        Pair secondBox = sort2(new Pair(firstBox.second,  t.c));
        Pair thirdBox  = sort2(new Pair(secondBox.second, t.d));
        Pair fourthBox = sort2(new Pair(thirdBox.second,  t.e));

        return new FiveTuple(firstBox.first,
                             secondBox.first,
                             thirdBox.first,
                             fourthBox.first,
                             fourthBox.second);
    }

    public static FiveTuple sort5(FiveTuple t) {
        // perform n-1 passes where n is the number of elements in the tuple.
        // after i passes, you know the last i elements are in their final position.
        // after you know that n-1 elements are in their final position, the
        // remaining element must also be in the final position.
        return singleBubble(
                singleBubble(
                 singleBubble(
                  singleBubble(t))));
    }

    public static void main(String[] args) {
        System.out.println(sort5(new FiveTuple(1, 4, 3, 2, 5))); // (1, 2, 3, 4, 5)
        System.out.println(sort5(new FiveTuple(4, 3, 1, 4, 1))); // (1, 1, 3, 4, 4)
    }

}
