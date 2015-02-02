
function[mat] = rowOp(A,rownum,colnum,srow)

  mat = A;

  mat(rownum,:) = mat(rownum,:)-((mat(rownum,colnum)/mat(srow,colnum))*mat(srow,:));

  return

endfunction


function[mat] = matrixEqSolver(A,b)

  mat = [A,b];

  mat = rowOp(mat,2,1,1);
  mat = rowOp(mat,3,1,1);

  if (mat(2,2) != 0)
    mat = rowOp(mat,3,2,2);
    if (mat(3,3) != 0)
      mat = rowOp(mat,2,3,3);
      mat = rowOp(mat,1,3,3);
    endif
    mat = rowOp(mat,1,2,2);
  else
    mat = rowOp(mat,1,2,3);
  endif

  mat(1,:) = mat(1,:)/mat(1,1);

  if (mat(2,2) != 0)
    mat(2,:) = mat(2,:)/mat(2,2);
    if (mat(3,3) != 0)
      mat(3,:) = mat(3,:)/mat(3,3);
    endif
  else
    mat(3,:) = mat(3,:)/mat(3,2);
  endif

  

  return

endfunction



