
function integer rand_chance;
      input [31:0] chance_true;

      begin
	 if (chance_true > 100)
	   begin
	      $display("RAND_CHANCE-E-: fatal error, rand_chance called with percent chance larger than 100.\tTime: %0d ns", $time);
	      $finish;
	   end
	 rand_chance = (rand(1,100) <= chance_true);
      end
endfunction // rand_chance


function integer rand;
      input [31:0] min;
      input [31:0] max;

      integer      range;
      begin
	 if (min > max)
	   begin
	      $display("RAND-E-: fatal error, rand was called with min larger than max.\tTime: %0d ns", $time);
	      $finish;
	   end

	 range = (max - min) + 1;
	 if (range == 0) range = -1;
	 rand  = min + ($random % range); 
      end
endfunction // rand


function integer align;
      input [31:0]  num;
      input [31:0]  align_size;
      
      integer       align;
      begin
         align = num - (num % align_size);
      end
endfunction


function integer rand_align;
      input [31:0] min;
      input [31:0] max;
      input [31:0] align;

      integer      rand_align;
      begin
         rand_align = rand(min, max);
         
         if (rand_align > align)
           rand_align = align(rand_align, align);
      end
endfunction

