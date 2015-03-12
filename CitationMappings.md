# BibApp Citation Import Mappings #

| BibApp | RIS | RefWorks XML | MedLine | Notes |
|:-------|:----|:-------------|:--------|:------|
| name strings, role: author | a1, au | a1 | au, fau |  |
| name strings, role: editor | a2, ed | a2 |  |  |
| title primary | ct, t1, ti | t1 | ti |  |
| title secondary | bt, t2 | t2 |  |  |
| title tertiary | t3 | t3 |  |  |
| keywords | kw | k1, u2 | mh |  |
| pub date | py, y1, y2 | yr, fd | dp | RefWorks XML uses yr (year) and fd (full date); RIS uses py & y1 (date primary) and y2 (date secondary) |
| publication | j1, j2, ja, jf, jo | jf, jo | jt, ta |  |
| volume | vl | vo | vi |  |
| issue | is, cp | is | ip |  |
| start page | sp | sp | pg |  |
| end page | ep | op | pg |  |
| publisher | pb | pb | pb |  |
| publication place | cy | pp | pl |  |
| isbn/issn | bn, sn | sn | is |  |
| affiliation? | ad | ad | ad |  |
| language |  | la | la |  |
| links | l1, l2, ur | lk, do | aid |  |
| abstract | n2 | ab | ab |  |
| notes | ab, m1, m2, m3, n1 | no | stat |  |
| identifier | id |  |  |  |
| external ID |  |  | pmid |  |
| location | vl | ed |  | For conference works: location, RefWorks RIS uses vl (volume); XML uses ed (edition) |