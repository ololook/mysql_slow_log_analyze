low_file=$1
awk '$0~/^# User@Host|^# Query_time/{
                if(NR>1 &&$ 0!~/^# Query_time/)
                        {print "";printf $0;}
                else {print $0"";}
                                }' $1 |awk 'gsub(/#|@/,"",$0){ print $0}'| awk ' BEGIN {
                print "DB_Name_User ",
                "App_Server   ",
                      "T_Exe_Time   ",
                      "T_Loc_Time   ",
                      "T_Row_Ret    ",
                      "T_Row_Exa    ",
                      "T_Cnt_Sql    ",
                "q_<05        ",
                "q_>05        ",
                "q_>1         "
                 }
                        {
                                        a[$2" "$3]+=$5;
                                        b[$2" "$3]+=$7;
                                        c[$2" "$3]+=$9;
                                        d[$2" "$3]+=$11;
                                        e[$2" "$3]+=1;
                         if($5>0.1&&$5<0.5)  {f[$2" "$3]+=1};
                                        if($5>=0.5&&$5<=0.9999) {g[$2" "$3]+=1};
                                        if($5>=1) {h[$2" "$3]+=1}
                         {f[$2" "$3]+=0;g[$2" "$3]+=0;h[$2" "$3]+=0}
                                                                                }END {
                            for(i in a )
                                print i,
                                    a[i],
                                    b[i],
                                    c[i],
                                    d[i],
                                    e[i],
                        f[i],
                        g[i],
                        h[i]
                                }'  |column -t 