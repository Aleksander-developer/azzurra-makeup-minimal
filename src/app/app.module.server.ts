// src/app/app.server.module.ts

import { NgModule } from '@angular/core';
import { ServerModule } from '@angular/platform-server';
// ---> 1. IMPORTA QUESTO MODULO <---
import { NoopAnimationsModule } from '@angular/platform-browser/animations';

import { AppModule } from './app.module';
import { AppComponent } from './app.component';

@NgModule({
  imports: [
    AppModule,
    ServerModule,
    // ---> 2. AGGIUNGI QUESTO MODULO <---
    // Questa è la riga che risolve il crash.
    // Sostituisce BrowserAnimationsModule con una versione "innocua" sul server.
    NoopAnimationsModule
  ],
  bootstrap: [AppComponent],
})
export class AppServerModule {}