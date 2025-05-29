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
                                      // Removed the line below as per request:
                                      // uvUsernameController.text = value.hoSoUngVien.uvUsername ?? '';
                                    });
                                  },
                                );
                              }
                              // ...
                            },
                          ),
