import java.util.concurrent.locks.ReentrantLock;

class BetterSorry implements State {
    private volatile byte[] value;
    private byte maxval;

    BetterSorry(byte[] v) { 
        value = v;
        maxval = 127; 
    }

    BetterSorry(byte[] v, byte m) {
        value = v;
        maxval = m;
    }

    public int size() { return value.length; }

    public byte[] current() { return value; }

    public boolean swap(int i, int j) {
	if (value[i] <= 0 || value[j] >= maxval) {
	    return false;
	}

	value[i]--;
	value[j]++;
	return true;
    }
}