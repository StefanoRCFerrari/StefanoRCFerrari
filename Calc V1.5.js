const prompt = require('prompt-sync')();

let polinomio = prompt('Informe o polinômio (ex: 3x^2+5x-2): ');

let derivada = [];
let coefAux;
let coefVet = [];
let coefStr;
let coefInt;
let potAux;
let potVet = [];
let potStr;
let potInt;
let i; 

// --- Geração da Derivada de Primeira Ordem (f'(x)) --- (INALTERADA)
for (i = 0; i < polinomio.length; i++) {
    
    if (polinomio[i] === '+' || polinomio[i] === '-') {
        continue;
    }

    if (polinomio[i] === 'x') {
        // 1. Encontrar Coeficiente
        coefAux = 0; 
        coefVet = [];
        let sinal = 1;

        while (i - 1 - coefAux >= 0 && !isNaN(parseInt(polinomio[i - 1 - coefAux]))) {
            coefVet.unshift(polinomio[i - 1 - coefAux]);
            coefAux++;
        }
        coefStr = coefVet.join('');

        if (coefStr === '') {
            coefInt = 1;
        } else {
            coefInt = parseInt(coefStr);
        }

        let posSinal = i - 1 - coefAux;
        if (posSinal >= 0 && polinomio[posSinal] === '-') {
            sinal = -1;
        }
        coefInt = coefInt * sinal;

        // 2. Encontrar Potência
        potAux = 1;
        potVet = [];
        potStr = '';
        
        if (i + 1 < polinomio.length && polinomio[i + 1] === '^') {
            potAux = 2; 
            while (i + potAux < polinomio.length && !isNaN(parseInt(polinomio[i + potAux]))) {
                potVet.push(polinomio[i + potAux]);
                potAux++;
            }
            potStr = potVet.join('');
            potInt = parseInt(potStr);
            i += potAux - 1;
        } else {
            potInt = 1;
        }

        // 3. Aplicar Regra da Potência
        let novoCoef = coefInt * potInt;
        let novaPot = potInt - 1;
        
        if (novoCoef !== 0) {
            if (derivada.length > 0 && novoCoef > 0) {
                derivada.push('+');
            }

            if (novaPot > 1) {
                derivada.push(novoCoef);
                derivada.push('x');
                derivada.push('^');
                derivada.push(novaPot);
            } else if (novaPot === 1) {
                derivada.push(novoCoef);
                derivada.push('x');
            } else if (novaPot === 0) {
                derivada.push(novoCoef);
            }
        }
        
    } else if (!isNaN(parseInt(polinomio[i]))) {
        // Pula o termo constante, pois sua derivada é zero.
        let numAux = 0;
        while(i + numAux < polinomio.length && !isNaN(parseInt(polinomio[i+numAux]))) {
            numAux++;
        }
        i += numAux - 1; 
    }
}

// 4. Formatação da Primeira Derivada
let resultado = derivada.join('');
resultado = resultado.replace(/\-\-/g, '+').replace(/\+\-/g, '-');
if (resultado.startsWith('+')) {
    resultado = resultado.substring(1);
}
if (resultado === '' || resultado === '-' || resultado === '+') {
    resultado = '0';
}
console.log(`\nDerivada de Primeira Ordem (f'(x)): ${resultado}`);

// ---------------------------------------------------------------------------------------------------------------------------------

let derivada2 = [];
let coefAux2;
let coefVet2 = [];
let coefStr2;
let coefInt2;
let potAux2;
let potVet2 = [];
let potStr2;
let potInt2;
let j; 

// --- Geração da Derivada de Segunda Ordem (f''(x)) --- (INALTERADA)
for (j = 0; j < resultado.length; j++){
    
    if (resultado[j] === '+' || resultado[j] === '-') {
        continue;
    }

    if (resultado[j] === 'x'){
        // 1. Encontrar Coeficiente
        coefAux2 = 0; 
        coefVet2 = [];
        let sinal2 = 1;

        while (j - 1 - coefAux2 >= 0 && !isNaN(parseInt(resultado[j - 1 - coefAux2]))) {
            coefVet2.unshift(resultado[j - 1 - coefAux2]);
            coefAux2++;
        }
        coefStr2 = coefVet2.join('');

        if (coefStr2 === '') {
            coefInt2 = 1;
        } else {
            coefInt2 = parseInt(coefStr2);
        }

        let posSinal2 = j - 1 - coefAux2;
        if (posSinal2 >= 0 && resultado[posSinal2] === '-') {
            sinal2 = -1;
        }
        coefInt2 = coefInt2 * sinal2;
        
        // 2. Encontrar Potência
        potAux2 = 1;
        potVet2 = [];
        potStr2 = '';
        
        if (j + 1 < resultado.length && resultado[j + 1] === '^'){
            potAux2 = 2;
            while (j + potAux2 < resultado.length && !isNaN(parseInt(resultado[j + potAux2]))){
                potVet2.push(resultado[j + potAux2]);
                potAux2++;
            }
            potStr2 = potVet2.join('');
            potInt2 = parseInt(potStr2);
            j += potAux2 - 1;
        } else {
            potInt2 = 1;
        }

        // 3. Aplicar Regra da Potência
        let novoCoef2 = coefInt2 * potInt2;
        let novaPot2 = potInt2 - 1;

        if (novoCoef2 !== 0) {
            if (derivada2.length > 0 && novoCoef2 > 0) {
                derivada2.push('+');
            }

            if (novaPot2 > 1){
                derivada2.push(novoCoef2);
                derivada2.push('x');
                derivada2.push('^');
                derivada2.push(novaPot2);
            } else if (novaPot2 === 1){
                derivada2.push(novoCoef2);
                derivada2.push('x');
            } else if (novaPot2 === 0){
                derivada2.push(novoCoef2);
            }
        }
    } else if (!isNaN(parseInt(resultado[j]))) {
        // Pula o termo constante da primeira derivada (derivada de segunda ordem = 0)
        let numAux2 = 0;
        while(j + numAux2 < resultado.length && !isNaN(parseInt(resultado[j+numAux2]))) {
            numAux2++;
        }
        j += numAux2 - 1; 
    }
}

// 4. Formatação da Segunda Derivada
let segunda = derivada2.join('');
segunda = segunda.replace(/\-\-/g, '+').replace(/\+\-/g, '-');
if (segunda.startsWith('+')) {
    segunda = segunda.substring(1);
}
if (segunda === '' || segunda === '-' || segunda === '+') {
    segunda = '0';
}
console.log(`Derivada de Segunda Ordem (f''(x)): ${segunda}`);

// ---------------------------------------------------------------------------------------------------------------------------------

// --- CORREÇÃO NA EXTRAÇÃO DO TERMO CONSTANTE DA PRIMEIRA DERIVADA ---

let termoConstanteDerivada = 0;

// Percorre a derivada (resultado) para encontrar o termo constante no final
let k = resultado.length - 1;
let numAux;

// Retrocede pulando a parte numérica do último termo (seja ele constante ou com x)
if (resultado[k] !== 'x') {
    // 1. Encontra o fim do termo numérico
    let fimNum = k;
    while(k >= 0 && !isNaN(parseInt(resultado[k]))) {
        k--;
    }
    let inicioNum = k + 1;
    
    // 2. Verifica se o termo encontrado não é um coeficiente de x^0
    // (A lógica de derivação garante que se é um número solto no final, ele é o termo constante)
    
    // 3. Verifica se o número solto é a constante final ou se é o único termo
    if (inicioNum < resultado.length) {
        let termoConst = resultado.substring(inicioNum, fimNum + 1);
        let valorConst = parseInt(termoConst);

        // Verifica o sinal
        let sinal = 1;
        if (k >= 0 && resultado[k] === '-') {
            sinal = -1;
        }

        if (valorConst !== 0 && !isNaN(valorConst)) {
            termoConstanteDerivada = valorConst * sinal;
        }
    }
}

// --- Busca do Ponto Crítico (Método da Bisseção) ---
let inicio = parseFloat(prompt('\nInforme o início do intervalo para Ponto Crítico: '));
let fim = parseFloat(prompt('Informe o fim do intervalo para Ponto Crítico: '));
let tolerancia = parseFloat(prompt('Informe a margem de tolerância (epsilon): '));
let pontoMedio = (inicio + fim) / 2;

let resulIni;
let resulFim;
let resulPM;

let maxIteracoes = 1000;
let iteracao = 0;
let continuarBusca = true;

do {
    // Inicializa os resultados com o termo constante da derivada f'(x) (CORRIGIDO)
    resulIni = termoConstanteDerivada; 
    resulFim = termoConstanteDerivada;  
    resulPM = termoConstanteDerivada;  
    
    // O loop itera sobre a string da derivada (resultado)
    for (i = 0; i < resultado.length; i++) {
        if (resultado[i] === 'x') {
            
            // Lógica para obter o coeficiente e a potência do termo com 'x' da derivada (resultado)
            coefAux = 0; 
            coefVet = [];
            let sinal = 1;

            // 1. Encontrar Coeficiente (CORREÇÃO DE LÓGICA NO PARSING)
            // A lógica deve ser a mesma utilizada na construção da derivada para garantir a extração correta
            let posSinal = i - 1;
            while (posSinal >= 0 && !isNaN(parseInt(resultado[posSinal]))) {
                coefVet.unshift(resultado[posSinal]);
                posSinal--;
            }
            
            coefStr = coefVet.join('');

            if (coefStr === '') {
                coefInt = 1;
            } else {
                coefInt = parseInt(coefStr);
            }

            // Verifica o sinal
            if (posSinal >= 0 && resultado[posSinal] === '-') {
                sinal = -1;
            }
            // Se for o primeiro termo e começar com número sem sinal, não faz nada
            
            coefInt = coefInt * sinal;

            // 2. Encontrar Potência
            potAux = 1; 
            potVet = [];
            potStr = '';
            
            if (i + 1 < resultado.length && resultado[i + 1] === '^') {
                potAux = 2; 
                while (i + potAux < resultado.length && !isNaN(parseInt(resultado[i + potAux]))) {
                    potVet.push(resultado[i + potAux]);
                    potAux++;
                }
                potStr = potVet.join('');
                potInt = parseInt(potStr);
                i += potAux - 1; // Avança o contador principal para o final da potência
            } else {
                potInt = 1;
            }

            // 3. Avaliação do Termo
            let termo_ini = coefInt * (inicio ** potInt);
            let termo_fim = coefInt * (fim ** potInt);
            let termo_pm = coefInt * (pontoMedio ** potInt);
            
            resulIni += termo_ini;
            resulFim += termo_fim;
            resulPM += termo_pm;
            
            // O loop principal continua para o próximo termo com 'x'
        }
    }
    
    // Método da Bisseção
    if (Math.abs(resulPM) <= tolerancia) {
        continuarBusca = false;
    } else if (resulIni * resulPM > 0) {
        inicio = pontoMedio;
    } else {
        fim = pontoMedio;
    }
    
    // IMPORTANTE: Recalcula o ponto médio para a próxima iteração
    pontoMedio = (inicio + fim) / 2; 
    iteracao++;

    if (Math.abs(fim - inicio) <= tolerancia || iteracao >= maxIteracoes) {
        continuarBusca = false;
    }

} while (continuarBusca) 

// --- Saída dos Resultados ---
console.log('\n---------------------------------');
console.log(`Busca do Ponto Crítico (f'(x) ≈ 0):`);
console.log(`Derivada no ponto de início ${inicio.toFixed(2)}: ${resulIni.toFixed(4)}`);
console.log(`Derivada no ponto médio ${pontoMedio.toFixed(2)}: ${resulPM.toFixed(4)}`);
console.log(`Derivada no ponto final ${fim.toFixed(2)}: ${resulFim.toFixed(4)}`);
if (Math.abs(resulPM) <= tolerancia) {
    console.log(`Ponto crítico em x ≈ ${pontoMedio.toFixed(4)}`);
} else {
    console.log(`Ponto crítico não encontrado no intervalo informado ou a função não muda de sinal.`);
}
console.log('---------------------------------');