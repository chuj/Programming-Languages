import java.util.concurrent.atomic.AtomicIntegerArray;

class GetNSet implements State {
    private AtomicIntegerArray value;
    private byte maxval;

    GetNSet(byte[] v) { 
        int[] int_vals = new int[v.length];
        for (int i = 0; i < v.length; i++){
            int_vals[i] = v[i];
        }
        value = new AtomicIntegerArray(int_vals);
        maxval = 127; 
    }

    GetNSet(byte[] v, byte m) {
        int[] int_vals = new int[v.length];
        for (int i = 0; i < v.length; i++){
            int_vals[i] = v[i];
        }
        value = new AtomicIntegerArray(int_vals);
        maxval = m; 
    }

    public int size() { return value.length(); }

    public byte[] current() {
        byte[] curr = new byte[value.length()]; 
        for (int i = 0; i < value.length(); i++){
            curr[i] = (byte) value.get(i);
        }
        return curr;
    }

    public boolean swap(int i, int j) {
	if (value.get(i) <= 0 || value.get(j) >= maxval) {
	    return false;
	}
	
    value.set(i, value.get(i) - 1);
	
    value.set(j, value.get(j) + 1);
	
    return true;
    }
}

