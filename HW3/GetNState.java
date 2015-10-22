import java.util.concurrent.atomic.AtomicIntegerArray

class GetNSet implements State {
    private AtomicIntegerArray[] value;
    private byte maxval;

    GetNSet(byte[] v) { value = v; maxval = 127; }

    GetNSet(byte[] v, byte m) { value = v; maxval = m; }

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
