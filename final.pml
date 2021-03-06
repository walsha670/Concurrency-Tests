/* Based on fa1.pml  Copyright 2007 by Moti Ben-Ari under the GNU GPL */

#define LEN 5
//[WORK ZONE]
inline Input(n) {
  if
  :: i[n] = 'a'
  :: i[n] = 'b'
  :: i[n] = 'c'
  :: i[n] = 'd' //added for new ndfa (d)
  fi
}


active proctype FA() {
  byte h;
  byte i[LEN];
  if
  //randomising accepting lengths
  ::Input(0); i[1]='.'; i[2]='.'; i[3]='.'; i[4]='.';
  ::Input(0); Input(1); i[2]='.'; i[3]='.'; i[4]='.';
  ::Input(0); Input(1); Input(2); i[3]='.'; i[4]='.';
  ::Input(0); Input(1); Input(2); Input(3); i[4]='.';
  fi
//redesigned example layout to suit final ndfa, 2 accepting nodes
q0: if
    :: i[h] == 'a'  -> printf("@TRANS q0 a q1\n"); h++; goto q1;
    :: i[h] == 'a'  -> printf("@TRANS q0 a q2\n"); h++; goto q2;
    :: i[h] == 'b'  -> printf("@TRANS q0 b q3\n"); h++; goto q3
    fi;
q1: if
    :: i[h] == 'd'  -> printf("@TRANS q1 d q3\n"); h++; goto q3
    fi;
q2: if
    :: i[h] == 'b'  -> printf("@TRANS q2 b q4\n"); h++; goto q4
    fi;
q3: if
    :: i[h] == 'c'  -> printf("@TRANS q3 c q2\n"); h++; goto q2;
    :: i[h] == 'c'  -> printf("@TRANS q3 c q6\n"); h++; goto q6;
    :: i[h] == 'd'  -> printf("@TRANS q3 c q5\n"); h++; goto q5;
    :: i[h] == '.'  -> printf("@TRANS q3 . accept\n"); goto accept
    fi;
q4: if
    :: i[h] == 'a'  -> printf("@TRANS q4 a q2\n"); h++; goto q2;
    :: i[h] == 'b'  -> printf("@TRANS q4 b q5\n"); h++; goto q5;
    :: i[h] == 'c'  -> printf("@TRANS q4 c q6\n"); h++; goto q6
    fi;
q5: if 
    :: i[h] == 'a'  -> printf("@TRANS q5 a q4\n"); h++; goto q4;
    :: i[h] == 'b'  -> printf("@TRANS q5 b q1\n"); h++; goto q1
    fi;
q6: if
    :: i[h] == '.'  -> printf("@TRANS q6 . accept\n"); goto accept
    fi;
accept:
    printf("Accepted!\n");
	assert(false)
}
//[WORK ZONE]
active proctype Watchdog() {
end:	timeout -> printf("Rejected ...\n")
}
