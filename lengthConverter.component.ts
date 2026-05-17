import {Component, OnInit} from '@angular/core';

@Component({
  selector: 'length-converter',
  templateUrl: './lengthConverter.component.html',
  styleUrls: ['./lengthConverter.component.scss']
})
export class LengthConverter implements OnInit {
  lengthOptions = [
    {
      id: 0,
      label: 'Kilometre',
      unit: 'km'
    },
    {
      id: 1,
      label: 'Metre',
      unit: 'm'
    },
    {
      id: 2,
      label: 'Centimetre',
      unit: 'cm'
    }
  ];

  amount1: number | null = null;
  amount2: number | null = null;
  
  unit1: number = 1;
  unit2: number = 0;

  rates = {
    0: 1000,
    1: 1,
    2: 0.01
  };

  ngOnInit() {
  }

  onAmount1Change(value: number) {
    this.amount1 = value;
    this.convert(1);
  }

  onAmount2Change(value: number) {
    this.amount2 = value;
    this.convert(2);
  }

  onUnit1Change(value: number) {
    this.unit1 = Number(value);
    this.convert(1);
  }

  onUnit2Change(value: number) {
    this.unit2 = Number(value);
    this.convert(1);
  }

  convert(source: number) {
    if (source === 1) {
      if (this.amount1 === null || this.amount1 === undefined) {
        this.amount2 = null;
        return;
      }
      const inMeters = this.amount1 * this.rates[this.unit1];
      const val = inMeters / this.rates[this.unit2];
      this.amount2 = Math.round(val * 10000) / 10000;
    } else {
      if (this.amount2 === null || this.amount2 === undefined) {
        this.amount1 = null;
        return;
      }
      const inMeters = this.amount2 * this.rates[this.unit2];
      const val = inMeters / this.rates[this.unit1];
      this.amount1 = Math.round(val * 10000) / 10000;
    }
  }

  getUnitLabel(id: number) {
    const option = this.lengthOptions.find(o => o.id === id);
    return option ? option.unit : '';
  }
}
