                          BlocBuilder<NTVBloc, NTVState>(
                            bloc: _ntvBloc,
                            builder: (context, state) {
                              if (state is NTVLoaded) {
                                // ...
                                return GenericPicker<HoSoUngVienPickerItem>(
                                  // ...
                                  onChanged: (value) {
                                    setState(() {
                                      selectedHoSoUngVien = value?.hoSoUngVien;
                                      if (value != null) {
                                        uvUsernameController.text =
                                            value.hoSoUngVien.uvUsername ?? '';
                                      }
                                    });
                                  },
                                );
                              }
                              // ...
                            },
                          ),
