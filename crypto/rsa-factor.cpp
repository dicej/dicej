#include <stdio.h>
#include <gmp.h>
#include <mpfr.h>

namespace {

const unsigned Precision = 8192;
const mpfr_rnd_t Round = MPFR_RNDA;

void challenge1() {
  mpfr_t N; mpfr_init2(N, Precision);
  mpfr_set_str(N, "179769313486231590772930519078902473361797697894230657273430081157732675805505620686985379449212982959585501387537164015710139858647833778606925583497541085196591615128057575940752635007475935288710823649949940771895617054361149474865046711015101563940680527540071584560878577663743040086340742855278549092581", 10, Round);
  
  mpfr_printf("N  %.0Rf\n", N);

  mpfr_t A; mpfr_init2(A, Precision);
  mpfr_sqrt(A, N, Round);
  mpfr_ceil(A, A);
  
  mpfr_printf("A  %.0Rf\n", A);

  mpfr_t x; mpfr_init2(x, Precision);
  mpfr_pow_ui(x, A, 2, Round);
  mpfr_sub(x, x, N, Round);
  mpfr_sqrt(x, x, Round);

  mpfr_printf("x  %.0Rf\n", x);

  mpfr_t p; mpfr_init2(p, Precision);
  mpfr_sub(p, A, x, Round);

  mpfr_printf("p  %.0Rf\n", p);

  mpfr_t q; mpfr_init2(q, Precision);
  mpfr_add(q, A, x, Round);

  mpfr_printf("q  %.0Rf\n", q);

  mpfr_t pq; mpfr_init2(pq, Precision);
  mpfr_mul(pq, p, q, Round);

  mpfr_printf("pq %.0Rf\n", pq);

  mpz_t pz; mpz_init(pz);
  mpfr_get_z(pz, p, Round);

  printf("p prime? %d\n", mpz_probab_prime_p(pz, 100));

  mpz_t qz; mpz_init(qz);
  mpfr_get_z(qz, q, Round);

  printf("q prime? %d\n", mpz_probab_prime_p(qz, 100));

  mpz_t phi; mpz_init(phi);
  mpz_t tmp; mpz_init(tmp);
  mpz_sub_ui(tmp, pz, 1);
  mpz_sub_ui(phi, qz, 1);
  mpz_mul(phi, phi, tmp);
  
  gmp_printf("phi %Zd\n", phi);

  mpz_t e; mpz_init(e);
  mpz_set_str(e, "65537", 10);
  
  gmp_printf("e  %Zd\n", e);
  
  mpz_t d; mpz_init(d);
  mpz_invert(d, e, phi);
  
  gmp_printf("d  %Zd\n", d);

  mpz_t c; mpz_init(c);
  mpz_set_str(c, "22096451867410381776306561134883418017410069787892831071731839143676135600120538004282329650473509424343946219751512256465839967942889460764542040581564748988013734864120452325229320176487916666402997509188729971690526083222067771600019329260870009579993724077458967773697817571267229951148662959627934791540", 10);

  mpz_t Nz; mpz_init(Nz);
  mpfr_get_z(Nz, N, Round);

  mpz_t m; mpz_init(m);
  mpz_powm(m, c, d, Nz);
  
  gmp_printf("m  %Zx\n", m);
}

void challenge2() {
  mpfr_t N; mpfr_init2(N, Precision);
  mpfr_set_str(N, "648455842808071669662824265346772278726343720706976263060439070378797308618081116462714015276061417569195587321840254520655424906719892428844841839353281972988531310511738648965962582821502504990264452100885281673303711142296421027840289307657458645233683357077834689715838646088239640236866252211790085787877", 10, Round);
  
  mpfr_printf("N  %.0Rf\n", N);

  mpfr_t A; mpfr_init2(A, Precision);  
  mpfr_t x; mpfr_init2(x, Precision);
  mpfr_t p; mpfr_init2(p, Precision);
  mpfr_t q; mpfr_init2(q, Precision);
  mpfr_t pq; mpfr_init2(pq, Precision);
  mpz_t pz; mpz_init(pz);
  mpz_t qz; mpz_init(qz);

  for (int i = 0; i < 1024 * 1024; ++i) {
    mpfr_sqrt(A, N, Round);
    mpfr_ceil(A, A);
    mpfr_add_ui(A, A, i, Round);
    
    mpfr_pow_ui(x, A, 2, Round);
    mpfr_sub(x, x, N, Round);
    mpfr_sqrt(x, x, Round);

    mpfr_sub(p, A, x, Round);

    mpfr_add(q, A, x, Round);

    mpfr_mul(pq, p, q, Round);

    mpfr_get_z(pz, p, Round);

    mpfr_get_z(qz, q, Round);

    if (mpfr_cmp(N, pq) == 0) {
      mpfr_printf("A  %.0Rf\n", A);
      
      mpfr_printf("x  %.0Rf\n", x);
      
      mpfr_printf("p  %.0Rf\n", p);
      
      mpfr_printf("q  %.0Rf\n", q);
      
      mpfr_printf("pq %.0Rf\n", pq);
      
      printf("p prime? %d\n", mpz_probab_prime_p(pz, 100));
      printf("q prime? %d\n", mpz_probab_prime_p(qz, 100));

      break;
    }
  }
}

void challenge3() {
  mpfr_t N; mpfr_init2(N, Precision);
  mpfr_set_str(N, "720062263747350425279564435525583738338084451473999841826653057981916355690188337790423408664187663938485175264994017897083524079135686877441155132015188279331812309091996246361896836573643119174094961348524639707885238799396839230364676670221627018353299443241192173812729276147530748597302192751375739387929", 10, Round);
  
  mpfr_printf("N  %.0Rf\n", N);

  mpfr_t A; mpfr_init2(A, Precision);  
  mpfr_t x; mpfr_init2(x, Precision);
  mpfr_t tmp; mpfr_init2(tmp, Precision);
  mpfr_t p; mpfr_init2(p, Precision);
  mpfr_t q; mpfr_init2(q, Precision);
  mpfr_t pq; mpfr_init2(pq, Precision);
  mpz_t pz; mpz_init(pz);
  mpz_t qz; mpz_init(qz);

  for (int i = 0; i < 1; ++i) {
    mpfr_mul_ui(A, N, 6, Round);
    mpfr_sqrt(A, A, Round);
    mpfr_mul_ui(A, A, 2, Round);
    mpfr_ceil(A, A);
    mpfr_div_ui(A, A, 2, Round);    
    mpfr_add_ui(A, A, i, Round);
    
    mpfr_pow_ui(x, A, 2, Round);
    mpfr_mul_ui(tmp, N, 6, Round);
    mpfr_sub(x, x, tmp, Round);
    mpfr_sqrt(x, x, Round);

    mpfr_sub(p, A, x, Round);
    mpfr_div_ui(p, p, 3, Round);

    mpfr_add(q, A, x, Round);
    mpfr_div_ui(q, q, 2, Round);    
    
    mpfr_mul(pq, p, q, Round);
    
    mpfr_get_z(pz, p, Round);

    mpfr_get_z(qz, q, Round);

    if (true or mpfr_cmp(N, pq) == 0) {
      mpfr_printf("A  %Rf\n", A);
      
      mpfr_printf("x  %Rf\n", x);
      
      mpfr_printf("p  %Rf\n", p);
      
      mpfr_printf("q  %Rf\n", q);

      mpfr_printf("N  %Rf\n", N);      
      mpfr_printf("pq %Rf\n", pq);

      mpfr_sub(tmp, N, pq, Round);
      mpfr_printf("d  %Rf\n", tmp);
      
      printf("p prime? %d\n", mpz_probab_prime_p(pz, 100));
      printf("q prime? %d\n", mpz_probab_prime_p(qz, 100));

      if (mpfr_cmp(N, pq) == 0) break;
    }
  }
}

} // namespace

int main() {
  challenge1();
  challenge2();
  challenge3();
  
  return 0;
}
