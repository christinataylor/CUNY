for k=2:d
	ppn=polys(k); %polynomial number
	m=zeros(1,r); %initial values
	c= cbe(ppn,2); 
	c = c(2:end); % coefficients of the primitive polynomial
	deg = numel(c); %degree of the polynomial

	for i=1:r %first 8 values already given
		s = 0;

		for j = 1:deg
			s = bitxor(s,2^j*c(j)*m(i-j));
		end

		m(i)= bitxor(s,m(i-deg));
	end

	for j=1:r
	    h = cbe(m(j),2); % binary representation
	    numdigs = numel(h);
	    V(j- numdigs+1:j,j,k)= h';
    end
end




for k=2:d
	ppn=polys(k); %polynomial number
	m=ivals(k,:); %initial values
	c= cbe(ppn,2); 
	c = c(2:end); % coefficients of the primitive polynomial
	deg = numel(c); %degree of the polynomial

	for i=9:r %first 8 values already given
		s = 0;

		for j = 1:deg
			s = bitxor(s,2^j*c(j)*m(i-j));
		end

		m(i)= bitxor(s,m(i-deg));
	end

	for j=1:r
	    h = cbe(m(j),2); % binary representation
	    numdigs = numel(h);
	    V(j- numdigs+1:j,j,k)= h';
    end
end


for k=2:d
	ppn=polys(k); %polynomial number
	m=ivals(k,:); %initial values
	c= cbe(ppn,2); 
	c = c(2:end); % coefficients of the primitive polynomial
	deg = numel(c); %degree of the polynomial

	for i=3:r %first 8 values already given
		s = 0;

		for j = 1:deg
			s = bitxor(s,2^j*c(j)*m(i-j));
		end

		m(i)= bitxor(s,m(i-deg));
	end

	for j=1:r
	    h = cbe(m(j),2); % binary representation
	    numdigs = numel(h);
	    V(j- numdigs+1:j,j,k)= h';
    end
end