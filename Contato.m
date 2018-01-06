//
//  Contato.m
//  CaelumIP67
//
//  Created by ios7289 on 1/6/18.
//  Copyright © 2018 Caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

-(NSString *)description{
    return [NSString stringWithFormat:@"Nome: %@, Telefone: %@, Endereco: %@, Site: %@", self.nome,self.telefone,self.endereco,self.site];
}


@end
