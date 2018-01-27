//
//  Contato.m
//  CaelumIP67
//
//  Created by ios7289 on 1/6/18.
//  Copyright © 2018 Caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

@dynamic nome, telefone, endereco, site, latitude, longitude, foto;

-(NSString *)description{
    return [NSString stringWithFormat:@"Nome: %@, Telefone: %@, Endereco: %@, Site: %@", self.nome,self.telefone,self.endereco,self.site];
}

-(CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

-(NSString *)title{
    return self.nome;
}

-(NSString *)subtitle{
    return self.site;
}

@end
